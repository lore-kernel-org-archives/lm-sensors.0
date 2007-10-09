From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Oct 2007 18:22:54 +0000
Subject: Re: [lm-sensors] [ANNOUNCE] superiotool -- Detect Super I/Os,
Message-Id: <20071009202254.50960c35@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071008013540.GB12533@greenwood>
In-Reply-To: <20071008013540.GB12533@greenwood>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 9 Oct 2007 19:54:24 +0200, Uwe Hermann wrote:
> On Tue, Oct 09, 2007 at 07:14:29PM +0200, Jean Delvare wrote:
> > We tell users to use isadump for that. As isadump is part of the
> > lm-sensors package, we can be reasonably certain that it is available
> > to the users. And more often than not, we need the dump of the
> > LDN-specific I/O space, which superio doesn't support as far as I can s=
ee.
>=20
> It dumps the per-LDN register contents, not sure if that's the same as
> the I/O space you're referring to? If no, then it's not supported, correc=
t.

No, that's not the same I/O space. What I'm talking about is the I/O
space those address is typically stored in registers 0x60 and 0x61 for
a given logical device.

> > * The human-readable dump of my F71805FG chip includes:
> > 27=20
> > 29=00
> > 2a=FF
> > 2b=FF
> > That's not exactly human-readable by my definition ;)
>=20
> Yeah, that was the initial format in the very early days, the plain
> register dump feature came later and we redeclared the old format
> to be the "human-readable" format for now (but it really needs lots of
> improvements, and isn't available for all chips anyway).
>=20
> This is likely a _very_ chip-specific feature, so we need one extra
> function with tons of custom printf's per chip. I'm not too sure if
> this is really _that_ useful to warrant such an amount of work, but
> we'll see...

I don't know if it's worth the effort, but if not, then you should
probably not print these values at all. They're available in the other
dump format anyway.

> > I've also hit a strange bug with -v (no kidding), I'll send a patch
> > when I'm done fixing it.
>=20
> Yeah, known issue (if we're talking about the same one). See the thread
> starting here http://linuxbios.org/pipermail/linuxbios/2007-October/02546=
1.html
> for a discussion and possible solutions. We haven't yet found the best
> way to do it, but will have to choose one soonish.

No, I didn't go that far. My concern was simply that strncpy is
misused. strncpy doesn't null-terminate the string it copies, so you
end up passing an invalid string to printf.

I have a simple fix using atoi instead of the ugly strncpy/strlen mix
you have:

 superiotool.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- superiotool.orig/superiotool.c	2007-10-09 19:48:15.000000000 +0200
+++ superiotool/superiotool.c	2007-10-09 19:53:43.000000000 +0200
@@ -170,12 +170,7 @@ void probing_for(const char *vendor, con
=20
 static void print_version(void)
 {
-	char tmp[80];
-
-	strncpy((char *)&tmp,
-		(const char *)&SUPERIOTOOL_VERSION[6],
-		strlen(SUPERIOTOOL_VERSION) - 8);
-	printf("superiotool r%s\n", (char *)&tmp);
+	printf("superiotool r%d\n", atoi(&SUPERIOTOOL_VERSION[6]));
 }
=20
 int main(int argc, char *argv[])

But of course it will conflict with the patch you posted.

I don't like your patch at all, BTW. At this point of complexity you
have to admit that you're doing something wrong and give up ;) Why
don't you use arbitrary version numbers as every other projects do?
This is much more valuable than SVN revision numbers, and much easier
to maintain than what you're trying to do.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
