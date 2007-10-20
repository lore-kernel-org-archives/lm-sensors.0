From: "Jim Cromie" <jim.cromie@gmail.com>
Date: Sat, 20 Oct 2007 15:51:29 +0000
Subject: Re: [lm-sensors] [ patch .24-rc0 5/5 ] SuperIO locks coordinator -
Message-Id: <cfe85dfa0710200851l3cdd0041n9ff14d969b3641d5@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4712F66F.8040806@gmail.com>
In-Reply-To: <4712F66F.8040806@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

missed cc to list

On 10/20/07, Jim Cromie <jim.cromie@gmail.com> wrote:
> On 10/18/07, David Hubbard <david.c.hubbard@gmail.com> wrote:
> > Hi Jim,
> >
>
> hi David,   thanks for the very helpful reply.
> sorry for delay responding
>
> > Three things:
> >
> > 1) This appears to be pasted in and needs to be updated for each driver:
> > printk(KERN_WARNING "pc87360: superio port not detected, "
> >
>
>  fixed here, thanks
>
> > 2) There's a compile warning in drivers/hwmon/superio_locks.c:
> >   CC [M]  drivers/hwmon/superio_locks.o
> > drivers/hwmon/superio_locks.c: In function 'superio_probe_reserve':
> > drivers/hwmon/superio_locks.c:44: warning: unused variable 'rc'
>
> rc is used in commented out code - placemarker for question - pc87360
> spec says that the sio-cmd-port is readable as well as writable, so I
> figured a write,read-back test was minimally risky (low false
> positive).  Turns out the test is nogood (false negative) on w83627hf.
> Ive dropped test here, but am soliciting input/viewpoint/thoughts on it.
>
> >
> > 3) superio_find() does not correctly find the w83627ehf:
> > # modprobe w83627ehf
> > [   84.162869] initializing with 3 reservation slots
> > [   84.188669] got devid 3, want 8850
>
>
> > it sees the port, but it doesn't see the devid. I added a whole bunch
> > of printks and I think the mask value is wrong (it gets a devid of
> > 8863 on my w83627ehf, and what we want is the 8860, not the 3, on port
> > 0x2e; 0x4e gives 0xffff.)
> >
> > So what I changed:
> > Index: linux-2.6.23-git8/drivers/hwmon/w83627ehf.c
> > =================================> > --- linux-2.6.23-git8/drivers/hwmon/w83627ehf.c 2007-10-18
> > 12:05:02.000000000 -0700
> > +++ linux-2.6.23-git8/drivers/hwmon/w83627ehf.c 2007-10-18
> > 12:36:21.000000000 -0700
> > @@ -79,7 +79,7 @@
> >  #define SIO_W83627EHF_ID       0x8850
> >  #define SIO_W83627EHG_ID       0x8860
> >  #define SIO_W83627DHG_ID       0xa020
> > -#define SIO_ID_MASK            0xFFF0
> > +#define SIO_ID_MASK            0xF
> >
> >  static struct superio* gate;
> >
> > @@ -1426,7 +1426,7 @@
> >         superio_enter(gate);
> >         val = superio_devid(gate);
> >
> > -       switch (val & SIO_ID_MASK) {
> > +       switch (val & (~SIO_ID_MASK)) {
> >         case SIO_W83627EHF_ID:
> >                 sio_data->kind = w83627ehf;
> >                 sio_name = sio_name_W83627EHF;
> > I didn't look at how other drivers do it, but I suspect if I had this
> > problem, w83627hf will have it too. Is this line in superio_locks.c
> > (around line 80, except I've patched up mine):
> > mydevid &= ~ where->devid_mask;
> >
> > Is it correct to invert the mask? Is every other driver inverting the
> > mask first? It seems you would want to flip the bits in the mask
> > constants, rather than invert every mask before using it. I didn't
> > find anywhere else that devid_mask was used.
>
> nice catch & analysis - ehf is only driver using devid-mask, so its
> the model :-)
> If I drop the tilde, things should work w/o the above change
>
> > Looking at that, I noticed this in your patch:
> >  /* w83627ehf_find() looks for a '627 in the Super-I/O config space */
> > -static int __init w83627ehf_find(int sioaddr, unsigned short *addr,
> > -                                struct w83627ehf_sio_data *sio_data)
> > +static int __init w83627ehf_find(struct w83627ehf_sio_data *sio_data)
> >  {
> >         static const char __initdata sio_name_W83627EHF[] = "W83627EHF";
> >         static const char __initdata sio_name_W83627EHG[] = "W83627EHG";
> >         static const char __initdata sio_name_W83627DHG[] = "W83627DHG";
> >
> > -       u16 val;
> > +       u16 val, addr;
> >         const char *sio_name;
> >
> > I don't think that is correct. We should return addr from
>
> ie diff-chunks doing a half-job on a fn-interface-change
>
> They do a 1/2-baked job changing ehf-find() sig and caller interface.
> The part not done is actually returning and assigning the addr.
> Im reverting them for now - maybe redo later as another patch
>
> Im pleased to note your wording above: "return addr from",
> that thinking is how the interface-change crept into the code..
>
>
> > w83627ehf_find into sensors_w83627ehf_init where you patched:
> > @@ -1496,7 +1483,7 @@ static struct platform_device *pdev;
> >  static int __init sensors_w83627ehf_init(void)
> >  {
> >         int err;
> > -       unsigned short address;
> > +       unsigned short address = 0;
> >         struct resource res;
> >         struct w83627ehf_sio_data sio_data;
> >
> > This line:
> >         if (!(pdev = platform_device_alloc(DRVNAME, address))) {
> >
> > uses the address to reserve the region (which should be 0x290 on my
> > machine) where the ISA interface to the w83627ehf is found. Then the
> > w83627ehf is used like some normal PnP device, with ports in the ISA
> > space.
> >
> > Hmm... so I hope this is valuable feedback. I could put together a
> > patch that undoes the change in the handling of addr, but I thought
> > I'd just shoot you back an email instead. So I'm lazy. :-)
> >
>
> hey, youre just doing some well-earned laurel-resting ;-)
> Your feedback was hugely helpful.
> new patchset forthcoming.
>
> > David
> >
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
