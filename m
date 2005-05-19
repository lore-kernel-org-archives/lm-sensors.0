From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: RH 7.3 /etc/rc.d/init.d/sensors
Message-Id: <3D1F9B2B.29A8BA1C@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200206220315.11079.mike808@users.sourceforge.net>
In-Reply-To: <200206220315.11079.mike808@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yes I read the tops of both files. I was hoping for something to use
for a README so people could decide between the two scripts,
without having to write it myself. Oh well.
I pasted what you gave me and made a README.
checked in.
thanks



mike808 wrote:
> 
> On Sunday 23 June 2002 08:51 pm, Mark D. Studebaker wrote:
> > I think that's a great idea to make things easier for redhat people.
> > You called them both sensors, I guess the second one is really
> > sensors.init?
> 
> The big fat script is /etc/rc.d/init.d/sensors
> 
> The small one with just the MODULE_# variable definitions goes into
> /etc/sysconfig/sensors. The first line of the file is a comment that says
> exactly this. Did you read them?
> 
> They're both called "sensors". It might be better to rename these "lm_sensors"
> to better fit with the RPM/module naming.
> 
> > I'm not a Redhat expert, perhaps you could write a short "README" for us
> > giving a brief description of what these do, and how to install and
> > configure them?
> 
> The script /etc/rc.d/init.d/sensors is a nice startup/shutdown script.
> 
> On RH and other RH-based systems (MDK, notably) use this sort of startup
> mechanism (i.e. SVR4-based), as opposed to the everything-in-one-script
> (/etc/rc or /etc/rc.local) like the BSD-based systems do.
> 
> > Where should we put them - prog/init? We already have something called
> > sensors there, though, and you're sending 2 more - help :)
> >
> > Also please verify they're GPL.
> 
> Yup. They're your basic startup scripts. I "borrowed" the outline of the
> startup script from RH's apmd startup script. I'm not sure if the
> "condreload" function really makes any sense. And the "reload" function is
> just an alias for "restart", so I'm not sure it would be necessary either.
> 
> You should note that the /etc/sysconfig/sensors is only a list of modules - as
> would be determined by running sensors-detect. If you use these, you should
> change the instructions in sensors-detect for the cut-n-paste to reflect
> this.
> 
> Please read the comments in the files if you are confused about which file is
> which, and where it belongs. They are there to be read, after all.
> 
> I'm not quite setup to ask for CVS write priviledges, and I'm only
> contributing these two files right now.
> 
> Here's a patch for sensors-detect to automagically write the
> /etc/sysconfig/sensors for you. This is only useful on systems that use the
> SVR4 approach (i.e. RH, MDK, SuSE, etc.).
> 
> # diff -c sensors-detect sensors-detect.orig
> *** sensors-detect      Mon Jun 24 01:33:45 2002
> --- sensors-detect.orig Mon Jun 24 01:00:22 2002
> ***************
> *** 2587,2646 ****
>     print $configfile;
>     print "#----cut here----\n";
> 
> -   print "\nDo you want to generate /etc/sysconfig/sensors? (YES/no): ";
> -   if ($> != 0) {
> -     print "\nAs you are not root, we shall skip this step.\n";
> -   } else {
> -     if (not <STDIN> =~ /^\s*[Nn]/) {
> -       open(SYSCONFIG, ">/etc/sysconfig/sensors")
> -         or die "Sorry, can't create /etc/sysconfig/sensors ($!)?!?";
> -       print SYSCONFIG <<'EOT';
> - #    /etc/sysconfig/sensors - Defines modules loaded by
> /etc/rc.d/init.d/sensors
> - #    Copyright (c) 1998 - 2001  Frodo Looijaard <frodol@dds.nl>
> - #
> - #    This program is free software; you can redistribute it and/or modify
> - #    it under the terms of the GNU General Public License as published by
> - #    the Free Software Foundation; either version 2 of the License, or
> - #    (at your option) any later version.
> - #
> - #    This program is distributed in the hope that it will be useful,
> - #    but WITHOUT ANY WARRANTY; without even the implied warranty of
> - #    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - #    GNU General Public License for more details.
> - #
> - #    You should have received a copy of the GNU General Public License
> - #    along with this program; if not, write to the Free Software
> - #    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> - #
> - # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> -
> - #
> - # See also the lm_sensors homepage at:
> - #     http://www2.lm-sensors.nu/~lm78/index.html
> - #
> - # This file is used by /etc/rc.d/init.d/sensors and defines the modules to
> be
> - # loaded/unloaded. This file is sourced into /etc/rc.d/init.d/sensors.
> - #
> - # The format of this file is a shell script that simply defines the modules
> - # in order as normal variables with the special names:
> - #    MODULE_1, MODULE_2, MODULE_3, etc.
> - #
> - # List the modules that are to be loaded for your system
> - #
> - EOT
> -       print SYSCONFIG
> -        "# Generated by sensors-detect on " . scalar localtime . "\n";
> -       my @modules = grep /^modprobe /, split "\n", $modprobes;
> -       my $i = 1;
> -       my $sysconfig = "";
> -       foreach (@modules) {
> -         s/^modprobe //;
> -         $sysconfig .= "MODULE_$i=$_\n";
> -         $i++;
> -       }
> -       print SYSCONFIG $sysconfig;
> -       close(SYSCONFIG);
> -     }
> -   }
>   }
> 
>   main;
> --- 2587,2592 ----
> 
> Mike808/
> --
> () Join the ASCII ribbon campaign against HTML email and Microsoft-specific
> /\ attachments. If I wanted to read HTML, I would have visited your website!
> Support open standards.
