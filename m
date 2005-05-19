From: pascal.ronecker@centrale-lille.net (Pascal Ronecker)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: [Fwd: sensors, kernel 2.4.19, bttv ...]
Message-Id: <1067199850.14878.13.camel@lenny.homelinux.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1067191364.14649.3.camel@lenny.homelinux.net>
In-Reply-To: <1067191364.14649.3.camel@lenny.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 2003-10-26 at 19:34, Jean Delvare wrote:
> > It's me again... i just would like to add a word : I've just read i2c
> > 2.8.0 was included in kernels after 2.4.21.
> 
> No, it isn't. Where did you read that? It might be that *distributions*
> patch the 2.4.21 kernels they are packaging with i2c 2.8.0, but it isn't
> part of the vanilla sources.
> 
oo-oops, I misunderstood something i read in the lm_sensors README : 
	"This lm_sensors release REQUIRES i2c-2.8.0 or later, which is 	not in
kernels through 2.4.21."
I'm sorry, i understood that as "after 2.4.21 it's okay". I thought i
was better at reading english, still have to enhance it seems :-))
(di dyou notice the ".fr" of my email ;-p)

> > Does it mean that simply upgrading my kernel from 2.4.19 to - say -
> > 2.4.22 will do the trick ?
> 
> No, it won't.
> 
> > I mean, then I'll only have to compile lm_sensors and everything will
> > be fine (bttv and i2c sensors ?)
> 
> You're invited to point your browser to:
> http://www.ensicaen.ismra.fr/~delvare/devel/i2c/
> and read carefully everything that is written there. You'll find the
> patches you need to be able to use i2c-2.8.x and still have bttv
> working. Basically, all you'll have to do is patch your kernel sources
> using one of the provided patches (i2c 2.8.0 for Linux 2.4.21 or i2c
> 2.8.1 for Linux 2.4.22), then installing lm_sensors (same version as
> i2c) will be done as usual.
> 
> Let us know how it work for you.

I used the mkpatch.pl script to prepare a i2c patch for my kernel (the
"option 3" installation from the guide.
the kernel compiles fine, then lm_sensors compiles also.
A serious problem remains with bttv module that does not compile.
According to the insructions I read from the adress you gave me, i have
to patch th bttv-if.c file. But the patch doesn't apply, I tried
manually but I do not understand it well enough. 

Could you just help me with that ? (it is a small patch, manually
editing should do it)

here is the patch :

	diff --exclude=media -ru bttv-0.9.11-orig/bttv-if.c
	bttv-0.9.11-i2c/bttv-if.c
	--- bttv-0.9.11-orig/bttv-if.c	Wed Jun 25 18:26:49 2003
	+++ bttv-0.9.11-i2c/bttv-if.c	Sun Aug  3 15:33:34 2003
	@@ -190,7 +190,7 @@
	 	return state;
	 }
	 
	-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,54)
	+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,9)
	 static void bttv_inc_use(struct i2c_adapter *adap)
	 {
	 	MOD_INC_USE_COUNT;
	@@ -243,9 +243,8 @@
	 };
	 
	 static struct i2c_adapter bttv_i2c_adap_template = {
	-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
	+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,9)
	 	.owner             = THIS_MODULE,
	-	.class             = I2C_ADAP_CLASS_TV_ANALOG,
	 #else
	 	.inc_use           = bttv_inc_use,
	 	.dec_use           = bttv_dec_use,
	
	
and here my corresponding code, really tiny (original vanilla 2.4.19)

static void bttv_inc_use(struct i2c_adapter *adap)
{
        MOD_INC_USE_COUNT;
}



static struct i2c_adapter bttv_i2c_adap_template = {
        name:              "bt848",
        id:                I2C_HW_B_BT848,
        inc_use:           bttv_inc_use,
        dec_use:           bttv_dec_use,
        client_register:   attach_inform,
        client_unregister: detach_inform,
};


what should result of the editing ???
(there are either not enough minus/plus signs, or not enough, i'm
confused again ...)

thank you !


