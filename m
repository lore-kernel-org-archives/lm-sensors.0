From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: ticket #1291
Message-Id: <20030731131444.5c83a8c2.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030731110954.43f2f54e.khali@linux-fr.org>
In-Reply-To: <20030731110954.43f2f54e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 31 Jul 2003 12:48:08 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> 
> > > Maybe you need an additional header and library to get inb and outb
> > > on PPC. Could you please run the following commands and report
> > > outputs?
> > > 
> > > grep '^inb ' -r /usr/include/*
> > this gives me:
> > grep '^inb ' -r /usr/include/*
> > grep: Warnung: /usr/include/gnome-xml/libxml: Rekursive
> > Verzeichnisschleife.
> >  
> > grep: /usr/include/ioport.h: Zu viele Ebenen aus symbolischen Links
> > 
> > > grep '^outb ' -r /usr/include/*
> > this gives me:
> >  grep '^outb ' -r /usr/include/*
> > grep: Warnung: /usr/include/gnome-xml/libxml: Rekursive
> > Verzeichnisschleife.
> >  
> > grep: /usr/include/ioport.h: Zu viele Ebenen aus symbolischen Links
> 
> First, you really should fix the two warnings that show up. It's about
> bad symlinks if I understand german right.
> 
> Second, the grep commands did not find any inb or outb defs, let's try
> with a different regexp:
> 
> grep ' inb' -r /usr/include/*
gives me:
 grep '^outb ' -r /usr/include/*
grep: Warnung: /usr/include/gnome-xml/libxml: Rekursive Verzeichnisschleife.
 
grep: /usr/include/ioport.h: Zu viele Ebenen aus symbolischen Links
zeno@zrr:/usr/src/modules/lm_sensors-2.8.0/prog/dump$ grep ' inb' -r /usr/include/*
/usr/include/asm/io.h:#define inb(port)         in_8((u8 *)((port)+_IO_BASE))
/usr/include/asm/io.h:#define inb(port)         in_8((u8 *)((port)+_IO_BASE))
/usr/include/asm/io.h:#define inb_p(port)               inb((port))
/usr/include/asm/keyboard.h:#define kbd_read_input() inb(KBD_DATA_REG)
/usr/include/asm/keyboard.h:#define kbd_read_status() inb(KBD_STATUS_REG)
grep: Warnung: /usr/include/gnome-xml/libxml: Rekursive Verzeichnisschleife.
 
/usr/include/gtkmm-2.0/glibmm/convert.h:   * @param inbuf Bytes to convert.
/usr/include/gtkmm-2.0/glibmm/convert.h:   * @param inbytes_left In/out parameter, bytes remaining to convert in @a inbuf.
/usr/include/gtkmm-2.0/glibmm/convert.h:  size_t iconv(char** inbuf, gsize* inbytes_left, char** outbuf, gsize* outbytes_left);
grep: /usr/include/ioport.h: Zu viele Ebenen aus symbolischen Links
/usr/include/linux/atmbr2684.h: * Is there FCS inbound on this VC?  This currently isn't supported.
/usr/include/linux/gameport.h:          return inb(gameport->io);
/usr/include/linux/ipsec.h:#define IPSEC_LEVEL_USE              1       /* use outbound, don't require inbound */
/usr/include/linux/parport_pc.h:        unsigned char val = inb (DATA (p));
/usr/include/linux/parport_pc.h:        unsigned char ecr = inb (ECONTROL (p));
/usr/include/linux/parport_pc.h:        unsigned char dcr = inb (CONTROL (p));
/usr/include/linux/parport_pc.h:        unsigned char dsr = inb (STATUS (p));
/usr/include/linux/parport_pc.h:                dcr = i ? priv->ctr : inb (CONTROL (p));
/usr/include/linux/parport_pc.h:        return inb(STATUS(p));
/usr/include/linux/ppp_defs.h:    __u32 vjs_uncompressedin; /* inbound uncompressed packets */
/usr/include/linux/ppp_defs.h:    __u32 vjs_compressedin;   /* inbound compressed packets */
/usr/include/linux/ppp_defs.h:    __u32 vjs_errorin;    /* inbound unknown type packets */
/usr/include/linux/ppp_defs.h:    __u32 vjs_tossed;     /* inbound packets tossed because of error */
/usr/include/linux/sdla_ppp.h:  unsigned char   inbd_auth_peerID[1] PACKED; /* 4D: variable length inbound authenticated peer ID */
/usr/include/net/slcompress.h:  int sls_uncompressedin; /* inbound uncompressed packets */
/usr/include/net/slcompress.h:  int sls_compressedin;   /* inbound compressed packets */
/usr/include/net/slcompress.h:  int sls_errorin;        /* inbound unknown type packets */
/usr/include/net/slcompress.h:  int sls_tossed;         /* inbound packets tossed because of error */
/usr/include/opencdk.h:                        const void * inbuf, size_t insize,
/usr/include/X11/Xauth.h:     krb5_data         /* inbuf */,
/usr/include/X11/extensions/lbximage.h: unsigned char *         /* inbuf */,
/usr/include/X11/extensions/lbximage.h: unsigned char *         /* inbuf */,
/usr/include/X11/extensions/lbximage.h: char *                  /* inbuf */,
/usr/include/X11/extensions/lbximage.h: char *                  /* inbuf */,
/usr/include/X11/extensions/lbximage.h:char *                   /* inbuf */,
/usr/include/X11/extensions/lbximage.h:unsigned char *          /* inbuf */,
/usr/include/X11/extensions/lbximage.h:char *                   /* inbuf */,
/usr/include/X11/extensions/lbximage.h:unsigned char *          /* inbuf */,

> grep ' outb' -r /usr/include/*
gives me:
 grep '^outb ' -r /usr/include/*
grep: Warnung: /usr/include/gnome-xml/libxml: Rekursive Verzeichnisschleife.
 
grep: /usr/include/ioport.h: Zu viele Ebenen aus symbolischen Links
zeno@zrr:/usr/src/modules/lm_sensors-2.8.0/prog/dump$ sudo grep '^outb ' -r /usr/include/*
Password:
grep: Warnung: /usr/include/gnome-xml/libxml: Rekursive Verzeichnisschleife.
 
grep: /usr/include/ioport.h: Zu viele Ebenen aus symbolischen Links
zeno@zrr:/usr/src/modules/lm_sensors-2.8.0/prog/dump$ grep '^inb ' -r /usr/include/*
grep: Warnung: /usr/include/gnome-xml/libxml: Rekursive Verzeichnisschleife.
 
grep: /usr/include/ioport.h: Zu viele Ebenen aus symbolischen Links
zeno@zrr:/usr/src/modules/lm_sensors-2.8.0/prog/dump$ grep '^outb ' -r /usr/include/*
grep: Warnung: /usr/include/gnome-xml/libxml: Rekursive Verzeichnisschleife.
 
grep: /usr/include/ioport.h: Zu viele Ebenen aus symbolischen Links
zeno@zrr:/usr/src/modules/lm_sensors-2.8.0/prog/dump$ grep ' inb' -r /usr/include/*
/usr/include/asm/io.h:#define inb(port)         in_8((u8 *)((port)+_IO_BASE))
/usr/include/asm/io.h:#define inb(port)         in_8((u8 *)((port)+_IO_BASE))
/usr/include/asm/io.h:#define inb_p(port)               inb((port))
/usr/include/asm/keyboard.h:#define kbd_read_input() inb(KBD_DATA_REG)
/usr/include/asm/keyboard.h:#define kbd_read_status() inb(KBD_STATUS_REG)
grep: Warnung: /usr/include/gnome-xml/libxml: Rekursive Verzeichnisschleife.
 
/usr/include/gtkmm-2.0/glibmm/convert.h:   * @param inbuf Bytes to convert.
/usr/include/gtkmm-2.0/glibmm/convert.h:   * @param inbytes_left In/out parameter, bytes remaining to convert in @a inbuf.
/usr/include/gtkmm-2.0/glibmm/convert.h:  size_t iconv(char** inbuf, gsize* inbytes_left, char** outbuf, gsize* outbytes_left);
grep: /usr/include/ioport.h: Zu viele Ebenen aus symbolischen Links
/usr/include/linux/atmbr2684.h: * Is there FCS inbound on this VC?  This currently isn't supported.
/usr/include/linux/gameport.h:          return inb(gameport->io);
/usr/include/linux/ipsec.h:#define IPSEC_LEVEL_USE              1       /* use outbound, don't require inbound */
/usr/include/linux/parport_pc.h:        unsigned char val = inb (DATA (p));
/usr/include/linux/parport_pc.h:        unsigned char ecr = inb (ECONTROL (p));
/usr/include/linux/parport_pc.h:        unsigned char dcr = inb (CONTROL (p));
/usr/include/linux/parport_pc.h:        unsigned char dsr = inb (STATUS (p));
/usr/include/linux/parport_pc.h:                dcr = i ? priv->ctr : inb (CONTROL (p));
/usr/include/linux/parport_pc.h:        return inb(STATUS(p));
/usr/include/linux/ppp_defs.h:    __u32 vjs_uncompressedin; /* inbound uncompressed packets */
/usr/include/linux/ppp_defs.h:    __u32 vjs_compressedin;   /* inbound compressed packets */
/usr/include/linux/ppp_defs.h:    __u32 vjs_errorin;    /* inbound unknown type packets */
/usr/include/linux/ppp_defs.h:    __u32 vjs_tossed;     /* inbound packets tossed because of error */
/usr/include/linux/sdla_ppp.h:  unsigned char   inbd_auth_peerID[1] PACKED; /* 4D: variable length inbound authenticated peer ID */
 and a lot more...

How would I be able to fix those symlinks?

Thanks for Feedback.
Zeno
