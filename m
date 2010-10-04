From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 04 Oct 2010 15:42:06 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: LTC4261 Hardware monitoring driver
Message-Id: <1286206926.2112.118.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284784361-18893-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1284784361-18893-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2010-10-04 at 11:21 -0400, Ira W. Snyder wrote:
> On Sun, Oct 03, 2010 at 06:18:07PM -0700, Guenter Roeck wrote:
> > Hi Ira,
> > 
> > On Sun, Oct 03, 2010 at 05:17:42PM -0400, Ira W. Snyder wrote:
> > > On Sun, Oct 03, 2010 at 06:29:34PM +0200, Jean Delvare wrote:
> > > > On Fri, 17 Sep 2010 21:32:41 -0700, Guenter Roeck wrote:
> > > > > This driver adds support for Linear Technology LTC4261 I2C Negative
> > > > > Voltage Hot Swap Controller.
> > > > >
> > > > > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > > >
> > > > Ira, you are familiar with Linear Technology hardware monitoring
> > > > devices, would you mind reviewing this driver? Thanks.
> > > >
> > > 
> > > Sure, not a problem.
> > > 
> > > Guenter, there are only a few minor nitpicks below. Please fix them and
> > > then add this after your Signed-off-by line:
> > > Reviewed-by: Ira W. Snyder <iws@ovro.caltech.edu>
> > > 
> > > Overall, the driver looks ready for inclusion.
> > > 
> > Thanks a lot - feedback inline
> > 
> > > Ira
> > 
> > [...]
> > > 
> > > > > +
> > > > > +/* chip registers */
> > > > > +#define    LTC4261_STATUS  0x00    /* readonly */
> > > > > +#define    LTC4261_FAULT   0x01
> > > > > +#define    LTC4261_ALERT   0x02
> > > > > +#define    LTC4261_CONTROL 0x03
> > > > > +#define    LTC4261_SENSE_H 0x04
> > > > > +#define    LTC4261_SENSE_L 0x05
> > > > > +#define    LTC4261_ADIN2_H 0x06
> > > > > +#define    LTC4261_ADIN2_L 0x07
> > > > > +#define    LTC4261_ADIN_H  0x08
> > > > > +#define    LTC4261_ADIN_L  0x09
> > > > > +
> > > 
> > > Tabs after #define here should be spaces. Keep the tabs just before the
> > > numbers to keep things lined up. You got it right on the fault register
> > > bits below.
> > > 
> > Yes, I know. Always happens to me. Fixed that already right after I submitted the patch.
> > 
> > > > > +/*
> > > > > + * Fault register bits
> > > > > + */
> > > > > +#define FAULT_OV   (1<<0)
> > > > > +#define FAULT_UV   (1<<1)
> > > > > +#define FAULT_OC   (1<<2)
> > > > > +
> > > > > +struct ltc4261_data {
> > > > > +   struct device *hwmon_dev;
> > > > > +
> > > > > +   struct mutex update_lock;
> > > > > +   bool valid;
> > > > > +   unsigned long last_updated;     /* in jiffies */
> > > > > +
> > > > > +   /* Registers */
> > > > > +   u8 regs[10];
> > > > > +};
> > > > > +
> > > > > +static struct ltc4261_data *ltc4261_update_device(struct device *dev)
> > > > > +{
> > > > > +   struct i2c_client *client = to_i2c_client(dev);
> > > > > +   struct ltc4261_data *data = i2c_get_clientdata(client);
> > > > > +   struct ltc4261_data *ret = data;
> > > > > +
> > > > > +   mutex_lock(&data->update_lock);
> > > > > +
> > > > > +   if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
> > > 
> > > The datasheet claims that registers E-J (SENSE and ADIN/OV registers)
> > > are updated at 7.3 Hz. See page 21: Data Converter. A 1 Hz update rate
> > > is awfully slow for an application that wants to do fast monitoring. I
> > > think (HZ / 4) or (HZ / 6) would be better.
> > > 
> > Makes sense. I'll use HZ/4.
> > 
> > > > > +           int i;
> > > > > +
> > > > > +           /* Read registers -- 0x00 to 0x09 */
> > > > > +           for (i = 0; i < ARRAY_SIZE(data->regs); i++) {
> > > > > +                   int val;
> > > > > +
> > > 
> > > I'd move the "int i" and "int val" variable declarations to the top of
> > > the function. I don't have a strong preference, though.
> > > 
> > Common tendency is that a variable should be defined in the innermost block
> > of its use. I know I am not always strict with that rule, but try to follow
> > the idea.
> > 
> > [...]
> > 
> > > > > +MODULE_DEVICE_TABLE(i2c, ltc4261_id);
> > > > > +
> > > > > +/* This is the driver that will be inserted */
> > > > > +static struct i2c_driver ltc4261_driver = {
> > > > > +   .driver = {
> > > > > +              .name = "ltc4261",
> > > > > +              },
> > > > > +   .probe = ltc4261_probe,
> > > > > +   .remove = ltc4261_remove,
> > > > > +   .id_table = ltc4261_id,
> > > > > +};
> > > > > +
> > > 
> > > I'd align the equal signs, like the ltc4245 driver does. No strong
> > > preference, though. Like this:
> > > 
> > > static struct i2c_driver ltc4261_driver = {
> > >         .driver = {
> > >                 .name   = "ltc4261",
> > >         },
> > >         .probe          = ltc4261_probe,
> > >         .remove         = ltc4261_remove,
> > >         .id_table       = ltc4261_id,
> > > };
> > > 
> > The formatting is the result of Lindent, which doesn't seem to like
> > the extra blanks. In questions like this - where much of it is
> > personal preference - I prefer to go with the Lindent results.
> > 
> 
> For both this and the variable declarations above, I don't have a strong
> preference. They're just things I would personally do differently. Like
> Jean commented below, I don't use Lindent either. Please still add my
> Reviewed-by on the next version. You've fixed the stuff I was concerned
> about.
> 
Thanks!

As for Lindent ... working in an environment where everyone insists in a
personal coding style, I find it quite useful in helping to enforce a
common coding style without much argument about it. At the very least,
it establishes a common baseline. Of course, that only works if one
gives a good example. 

Also, I don't take the output of Lindent as written in stone (sometimes
its output is a bit odd), but tend to rely on it as common baseline if
there is a disagreement.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
