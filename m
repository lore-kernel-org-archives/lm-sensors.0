From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 27 Mar 2007 16:47:28 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] lm-sensors: add dme1737 support
Message-Id: <20070327184728.315da495.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703261746s586b6c85t2a6aa27423c74e6d@mail.gmail.com>
In-Reply-To: <191fb4ca0703261746s586b6c85t2a6aa27423c74e6d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Juerg,

On Tue, 27 Mar 2007 09:09:14 -0700, Juerg Haefliger wrote:
> On 3/27/07, Jean Delvare wrote:
> > On Tue, 27 Mar 2007 08:35:13 -0700, Juerg Haefliger wrote:
> > > Yes, 0x73 is the one I wanted. My datasheet is at rev 0.4
> >
> > I have rev 0.2.
> 
> Man, where the heck do you get all these datasheets from? :-)

I don't remember. All I know is that I tagged it "do not distribute",
which means that it's not public.

> > > If you don't feel comfortable with the new registers I don't have a
> > > problem going back to the original register set. I just thought
> > > something a little bit more unique and meaningful makes sense.
> >
> > I don't care either way as long as you know what you're doing. We can
> > always change it in the future if problems arise. So I've applied your
> > patch.
> >
> > About the Asus A8000, will it be detected as an SMSC DME1737 with the
> > current code in sensors-detect? Or do we need dedicated detection?
> >
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2005-June/012777.html
> 
> Yes, it will work just fine for the A8000.

OK, great. I've updated our Devices wiki page accordingly.

I hope to find some time to take a first look at your driver by the end
of the week. Can't promise anything, though.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
