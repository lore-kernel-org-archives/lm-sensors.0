From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: [Fwd: i2c-proc correction]
Message-Id: <3D7D4445.FAD4300E@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D78E1D0.FB57803C@paradyne.com>
In-Reply-To: <3D78E1D0.FB57803C@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Documentation/DocBook/procfs* appears to confirm that THIS_MODULE is the
key.


Mark Studebaker wrote:
> 
> Don't know - anybody?
> 
> Alexander Viro wrote:
> >
> > On Thu, 5 Sep 2002, Mark D. Studebaker wrote:
> >
> > > removed from i2c-proc.c. As the comments say, the code prevents module
> > > unloading
> > > if the /proc files are in use.
> >
> > So does setting ->owner on them.
> >
> > > Why is this a bad thing?
> >
> > Because module has no business messing with its own reference count.
> >
> > > Is there a better way to do it?
> >
> > See above.
> 
> Does Al mean we already do the right thing in i2c-dev.c:89
> static struct file_operations i2cdev_fops {
> owner:  THIS_MODULE,
> 
> and i2c-dev.c:495 int __init i2c_dev_init
> ...
> if (register_chrdev(I2C_MAJOR, "i2c", &i2cdev_fops))
> 
> If so, we need to find a method to verify his statement.
> Oh, Linus applied the reverse patch for this to 2.5.34.
> Albert
> --
> Albert Cranford Deerfield Beach FL USA
> ac9410@bellsouth.net
> 
> =======================================================> 
> 
> 
> Subject: Re: i2c-proc correction
> Date: Thu, 05 Sep 2002 22:51:55 -0400
> From: "Mark D. Studebaker" <mds@paradyne.com>
> Organization: Paradyne Networks, Largo FL
> To: viro@math.psu.edu
> CC: Albert Cranford <ac9410@attbi.com>
> References: <3D760B07.D1EFD4C8@attbi.com>
> 
> Al,
> 
> Albert Cranford and I work on the lm_sensors project.
> 
>  in May 2002 you removed what was called
>  "s390 procfs abuse" lines with i2c_fill_inode procedure in
> drivers/i2c/i2c-proc.c -
> kernel 2.5.18 -
> 
>  URL
> 
> http://linux.bkbits.net:8080/linux-2.5/diffs/drivers/i2c/i2c-proc.c@1.3?nav=index.html|src/.|src/drivers|src/drivers/i2c|hist/drivers/i2c/i2c-proc.c
> 
> We inadvertently put the lines back into kernel 2.5.32 with our recent
> patch. Sorry.
> We are submitting a patch to Linus (below) to take them back out in
> kernel 2.5.34.
> 
> However, I don't understand what 's390 procfs abuse' is or why these
> lines were
> removed from i2c-proc.c. As the comments say, the code prevents module
> unloading
> if the /proc files are in use. Why is this a bad thing? Is there a
> better way to do it?
> 
> Thank you very much for your help.
> 
> mds
> 
> > --- linux-2.5.33/drivers/i2c/i2c-proc.c.orig    2002-09-04 09:04:30.000000000 -0400
> > +++ linux/drivers/i2c/i2c-proc.c        2002-09-04 09:08:59.000000000 -0400
> > @@ -60,7 +60,6 @@
> >  static struct ctl_table_header *i2c_entries[SENSORS_ENTRY_MAX];
> >
> >  static struct i2c_client *i2c_clients[SENSORS_ENTRY_MAX];
> > -static unsigned short i2c_inodes[SENSORS_ENTRY_MAX];
> >
> >  static ctl_table sysctl_table[] = {
> >         {CTL_DEV, "dev", NULL, 0, 0555},
> > @@ -189,8 +188,6 @@
> >                 return id;
> >         }
> >  #endif                         /* DEBUG */
> > -       i2c_inodes[id - 256] > > -           new_header->ctl_table->child->child->de->low_ino;
> >         new_header->ctl_table->child->child->de->owner = controlling_mod;
> >
> >         return id;
> > @@ -213,49 +210,6 @@
> >         }
> >  }
> >
> > -/* Monitor access for /proc/sys/dev/sensors; make unloading i2c-proc.o
> > -   impossible if some process still uses it or some file in it */
> > -void i2c_fill_inode(struct inode *inode, int fill)
> > -{
> > -       if (fill)
> > -               MOD_INC_USE_COUNT;
> > -       else
> > -               MOD_DEC_USE_COUNT;
> > -}
> > -
> > -/* Monitor access for /proc/sys/dev/sensors/ directories; make unloading
> > -   the corresponding module impossible if some process still uses it or
> > -   some file in it */
> > -void i2c_dir_fill_inode(struct inode *inode, int fill)
> > -{
> > -       int i;
> > -       struct i2c_client *client;
> > -
> > -#ifdef DEBUG
> > -       if (!inode) {
> > -               printk(KERN_ERR "i2c-proc.o: Warning: inode NULL in fill_inode()\n");
> > -               return;
> > -       }
> > -#endif                         /* def DEBUG */
> > -
> > -       for (i = 0; i < SENSORS_ENTRY_MAX; i++)
> > -               if (i2c_clients[i]
> > -                   && (i2c_inodes[i] = inode->i_ino)) break;
> > -#ifdef DEBUG
> > -       if (i = SENSORS_ENTRY_MAX) {
> > -               printk
> > -                   (KERN_ERR "i2c-proc.o: Warning: inode (%ld) not found in fill_inode()\n",
> > -                    inode->i_ino);
> > -               return;
> > -       }
> > -#endif                         /* def DEBUG */
> > -       client = i2c_clients[i];
> > -       if (fill)
> > -               client->driver->inc_use(client);
> > -       else
> > -               client->driver->dec_use(client);
> > -}
> > -
> >  int i2c_proc_chips(ctl_table * ctl, int write, struct file *filp,
> >                        void *buffer, size_t * lenp)
> >  {
> >
