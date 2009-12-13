From: Luca Tettamanti <kronos.it@gmail.com>
Date: Sun, 13 Dec 2009 13:45:34 +0000
Subject: Re: [lm-sensors] [PATCH/RFC] hwmon(asus_atk0110): debugfs interface
Message-Id: <20091213134534.GA5011@nb-core2.darkstar.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091207161429.GA24289@nb-core2.darkstar.lan>
In-Reply-To: <20091207161429.GA24289@nb-core2.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Dec 12, 2009 at 10:45:42PM +0100, Jean Delvare wrote:
> Hi Luca,
> 
> On Mon, 7 Dec 2009 17:14:29 +0100, Luca Tettamanti wrote:
> > Expose the raw GGRP/GITM interface via debugfs. The hwmon interface is
> > reverse engineered and the driver tends to break on newer boards...
> > Using this interface it's possible to poke directly at the ACPI methods without
> > the need to recompile, reducing the guesswork and the round trips needed to
> > support a new revisions of the interface.
> > 
> > Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
> > ---
> > Does it make sense to have this upstream?
> 
> If it makes your life easier, then yes, it certainly makes sense. The
> size increase is reasonable.
> 
> However, I would like the size increase to be kept minimal when debugfs
> is not enabled. At the moment, all the debugging code is still included
> in that case. Functions atk_debugfs_ggrp_open, atk_debugfs_gitm_get,
> atk_debugfs_ggrp_read, atk_debugfs_gitm_open and
> atk_debugfs_ggrp_release are always included even when they will never
> be called.

Ok, I can wrap them up inside CONFIG_DEBUGFS.

> Review (note: I don't know anything about debugfs):
> > @@ -624,6 +630,193 @@
> >  	return err;
> >  }
> >  
> > +static int atk_debugfs_gitm_get(void *p, u64 *val)
> > +{
> > +	struct atk_data *data = p;
> > +	union acpi_object *ret;
> > +	struct atk_acpi_ret_buffer *buf;
> > +	int err = 0;
> > +
> > +	if (!data->read_handle)
> > +		return -ENODEV;
> > +
> > +	if (!data->debugfs.id)
> > +		return -EINVAL;
> > +
> > +	ret = atk_gitm(data, data->debugfs.id);
> > +	if (IS_ERR(ret))
> > +		return PTR_ERR(ret);
> > +
> > +	buf = (void *)ret->buffer.pointer;
> 
> This cast looks wrong. If a cast is really needed, you should cast to
> the right pointer type.

Right.

> > +static int atk_debugfs_ggrp_open(struct inode *inode, struct file *file)
> > +{
> > +	struct atk_data *data = inode->i_private;
> > +	union acpi_object *ret = NULL;
> 
> Initialization isn't needed.

Ok.

> > +	u8 cls;
> > +	char *buf = NULL;
> > +	size_t size = 512;
> 
> Makes little sense to have a variable for this.

true :)

> > +	int err;
> > +	int i;
> > +
> > +	if (!data->enumerate_handle)
> > +		return -ENODEV;
> > +	if (!data->debugfs.id)
> > +		return -EINVAL;
> > +
> > +	cls = (data->debugfs.id & 0xff000000) >> 24;
> > +	ret = atk_ggrp(data, cls);
> > +	if (IS_ERR(ret))
> > +		return PTR_ERR(ret);
> > +
> > +	for (i = 0; i < ret->package.count; i++) {
> > +		union acpi_object *pack = &ret->package.elements[i];
> > +		union acpi_object *id;
> > +
> > +		if (pack->type != ACPI_TYPE_PACKAGE)
> > +			continue;
> > +		id = &pack->package.elements[0];
> 
> Are packages guaranteed to always contain at least one element?

Good question. An empty package wouldn't make any sense in this context, but
it's better to check it anyway.

> > +		if (id->integer.value = data->debugfs.id) {
> > +			/* Print the package */
> > +			buf = kzalloc(size, GFP_KERNEL);
> > +			if (!buf) {
> > +				ACPI_FREE(ret);
> > +				err = -ENOMEM;
> > +				goto outerr;
> > +			}
> > +			atk_pack_print(buf, size, pack);
> > +			break;
> > +		}
> > +	}
> > +	ACPI_FREE(ret);
> > +
> > +	if (!buf) {
> > +		err = -EINVAL;
> > +		goto outerr;
> > +	}
> > +	file->private_data = buf;
> > +
> > +	return nonseekable_open(inode, file);
> > +outerr:
> > +	return err;
> 
> It makes little sense to have a common error path if you don't do
> anything in it.

Ok.

> > +static ssize_t atk_debugfs_ggrp_read(struct file *file, char __user *buf,
> > +		size_t count, loff_t *pos)
> > +{
> > +	char *str = file->private_data;
> > +	size_t len;
> > +
> > +	if (!str)
> > +		return -ENODEV;
> 
> This can't happen. If file->private_data is NULL, opening the file has
> failed.

I thought so :) It's the first time I fiddle the _fops interface.

> > +
> > +	len = strlen(str);
> > +
> > +	return simple_read_from_buffer(buf, count, pos, str, len);
> > +}
> > +
> > +static int atk_debugfs_ggrp_release(struct inode *inode, struct file *file)
> > +{
> > +	kfree(file->private_data);
> > +	return 0;
> > +}
> > +
> > +static struct file_operations atk_debugfs_ggrp_fops = {
> 
> Unless the API prevents it, this could be marked const.

Sure.

> > +	.read		= atk_debugfs_ggrp_read,
> > +	.open		= atk_debugfs_ggrp_open,
> > +	.release	= atk_debugfs_ggrp_release,
> > +};
> > +
> > +static int atk_debugfs_init(struct atk_data *data)
> > +{
> > +	struct dentry *d;
> > +	struct dentry *f;
> > +	int err;
> > +
> > +	d = debugfs_create_dir("asus_atk0110", NULL);
> > +	if (!d)
> > +		return -ENODEV;
> > +	if (IS_ERR(d))
> > +		return PTR_ERR(d);
> > +
> > +	f = debugfs_create_x32("id", S_IWUSR, d, &data->debugfs.id);
> 
> A write-only file, really? I would think that reading from this file
> would be valuable as well, and it wouldn't cost much.

The idea is that the user writes the ID in this file and read the data from the
others; the value in this file does not change; but as you said it costs
nothing to make it rw.

> > +	if (!f || IS_ERR(f)) {
> > +		err = -ENODEV;
> > +		goto cleanup;
> > +	}
> > +
> > +	f = debugfs_create_file("gitm", S_IRUSR, d, data,
> > +			&atk_debugfs_gitm);
> > +	if (!f || IS_ERR(f)) {
> > +		err = -ENODEV;
> > +		goto cleanup;
> > +	}
> > +
> > +	f = debugfs_create_file("ggrp", S_IRUSR, d, data,
> > +			&atk_debugfs_ggrp_fops);
> > +	if (!f || IS_ERR(f)) {
> > +		err = -ENODEV;
> > +		goto cleanup;
> > +	}
> > +
> > +	data->debugfs.root = d;
> > +	data->debugfs.id = 0;
> 
> I suspect you have a race condition here. You initialize debugfs.id
> only now, however the sysfs files which use it are already created, and
> user-space may have accessed them already.
> 
> (In fact you are lucky that the data structure was kzalloc'd so
> debugfs.id is already 0. But still...)

Yes, right. Will fix.

> > +
> > +	return 0;
> > +cleanup:
> > +	debugfs_remove_recursive(d);
> > +	return err;
> > +}
> > +
> > +static void atk_debugfs_cleanup(struct atk_data *data)
> > +{
> > +	debugfs_remove_recursive(data->debugfs.root);
> > +}
> > +
> >  static int atk_add_sensor(struct atk_data *data, union acpi_object *obj)
> >  {
> >  	struct device *dev = &data->acpi_dev->dev;
> > @@ -1180,6 +1373,8 @@
> >  	if (err)
> >  		goto cleanup;
> >  
> > +	atk_debugfs_init(data);
> 
> This function can fail, but you do not check the returned value.
> Apparently your code will deal fine with this condition, but it is still
> somewhat confusing, and it also means atk_debugfs_init() could be
> simplified quite a bit: you could omit error handling almost entirely
> in this function, if I'm not mistaken.

atk_debugfs_init has to cleanup in case of errors so it doesn't leave a half
initialized debugfs directory; the function can also fail if debugfs is not
enabled. Anyway the debugfs interface is not vital for the driver (i.e. it does
work fine without it), so at this point I don't care if debugfs is initialized
or not.
I will change the return value to void.

Thanks for the review Jean, I will send you an updated version of the patch.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
