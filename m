From: Andre Prendel <andre_prendel@gmx.de>
Date: Mon, 06 Apr 2009 10:21:13 +0000
Subject: Re: [lm-sensors] [PATCH 0/8] sensord: Some cleanups,
Message-Id: <20090406102113.GJ4734@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090406075553.GA4734@ubuntu>
In-Reply-To: <20090406075553.GA4734@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Apr 06, 2009 at 11:36:31AM +0200, Jean Delvare wrote:
> Hi Andre,
> 
> On Mon, 6 Apr 2009 09:55:53 +0200, Andre Prendel wrote:
> > Hello Jean,
> > 
> > this patch series fixes some issues caused by the coding style
> > conversion a while ago. Most of them are deep indentation levels and
> > the related long lines.
> > 
> > Another patch removes the hidden commandline interface. You can call
> > sensord as an console application if you have a link (sensors)
> > pointing to the sensors deamon (sensord). IMO that's really
> > intransparent and I don't know any reason using this.
> > 
> > Further there is a patch introducing a new structure
> > (sensord_arguments). The extern struct sensord_args in args.c now is
> > the place for all the commandline arguments.
> > 
> > A last one replaces the deprecated signal() function by sigaction.
> 
> Thanks for doing all this. Please note that I am pretty busy with
> kernel work these days so it will take some time before I can find the
> time to review your changes. Thanks for your patience :)

Take your time :)

Andre

> 
> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
