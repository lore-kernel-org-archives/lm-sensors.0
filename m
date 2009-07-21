From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 21 Jul 2009 14:20:20 +0000
Subject: Re: [lm-sensors] Another possible hwmon project
Message-Id: <20090721162020.70cdd215@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090624081700.GB4949@ubuntu>
In-Reply-To: <20090624081700.GB4949@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andre, Hans,

Sorry again for the late answer. I'm taking benefit of my forced
off-line time to answer my old e-mail.

On Fri, 26 Jun 2009 10:29:33 +0200, Andre Prendel wrote:
> Ok, that's a known issue. Sensors-detect already take care of it.
> 
> ---
> r5530 | khali | 2008-12-05 23:56:30 +0100 (Fr, 05. Dez 2008) | 3 lines
> 
> Alternatively look for DMI data in /sys/class/dmi/id, as
> /sys/devices/virtual/dmi/id only exists since kernel 2.6.28.
> 
> Index: prog/detect/sensors-detect
> =================================> --- prog/detect/sensors-detect	(Revision 5529)
> +++ prog/detect/sensors-detect	(Revision 5530)
> @@ -2150,11 +2150,13 @@
>    	    'System Manufacturer' => 1,
>  	    	    'System Name' => 1,
>  		    );
> +		    my $dmi_id_dir;
>  
> 	# First try reading the strings from sysfs if available
> -	if (-d "$sysfs_root/devices/virtual/dmi/id") {
> +	if (-d ($dmi_id_dir = "$sysfs_root/devices/virtual/dmi/id")	# kernel >= 2.6.28
> +	 || -d ($dmi_id_dir = "$sysfs_root/class/dmi/id")) {
>  	    foreach my $k (keys %items) {
> -	    	       $dmi{$k} = sysfs_device_attribute("$sysfs_root/devices/virtual/dmi/id", $k);
> +		       		  $dmi{$k} = sysfs_device_attribute($dmi_id_dir, $k);
>  				  	   }
>  					   } else {
>  					     # Else fallback on calling dmidecode
> ---
> 
> Looking for both should be the best.

Indeed, I had hit the problem before, and solved it with the above
patch. BTW, I do not think Andre will have too much work with the
DMI/SMBIOS part, because what's already in sensors-detect should be
good enough. We can discuss which strings exactly we want to use,
whether we want to clean them up and how, how to encode them etc. but
the fetching part should be robust by now.

Actually, I added DMI identification to sensors-detect with in mind the
idea of leveraging it for automatic configuration, just as Hans was
mentioning (and as was already discussed on the list in the past.) I am
not sure whether sensors-detect would be used for that, or a separate
script/tool, but at least the logic and possibly the code for the
DMI-based board identification should be reusable.
 
> > > BTW, Jean. Hans asked me for working on the automatic configuration of
> > > sensors using DMI information.
> > 
> > Ack, its still something which I would like to see done, so I suggested the
> > idea to Andre.

I also do think this should be done. My plan a few months ago was to
spend Novell's Hack Week IV on it, but it had to happen that this week
is the week I'm moving to a new flat, which means a few days without
easy Internet access, plus all the furniture to move around. So it was
definitely not the right week. But we can work on this together at any
later point anyway.

Slightly more into the details, my plan was a two-step one:

1* Come up with a filesystem-based storage structure for board-specific
   configuration files. For example:

   /usr/share/sensors/conf/dmi/by-board/$vendor/$board.conf
   /usr/share/sensors/conf/dmi/by-product/$vendor/$product.conf

   And add the logic to sensors-detect (or another script, this can be
   debated) to check for this file and propose to copy the
   configuration file to /etc/sensors.d.

2* Come up with a network-based storage structure for the same files.
   I am not going into the details here, this would be done later
   anyway and I have no precise idea of how to implement (and host) the
   service. There might be something about this in the document that
   was written by Jasper Alias, Ivo Manca and Gijs van der Weg back in
   February 2007 *sigh* which I admit I never read *re-sigh*.
   Andre, if you did not receive a copy of this document already, I can
   send it to you.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
