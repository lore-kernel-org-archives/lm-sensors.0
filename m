From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: error when compiling lm_sensors
Message-Id: <1075898161.4020e7318681c@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040204115112.GA4079@cereve.enpc.fr>
In-Reply-To: <20040204115112.GA4079@cereve.enpc.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Please reply to the list, not to me directly.]

Quoting Edouard Debry <debry@cereve.enpc.fr>:

> I had some pb to install lm_sensors_2.8.3 package, I did not know 
> who to talk to about this pb, so I first apologize if this mail 
> disturbs you

This is the right address for that kind of report.

> I currently run a 2.4.22 kernel ( slackware 9.1 ) and I tried to
> install lm_sensors_2.8.3 package
> 
> first I patched the kernel with the advised patches on your downlaod
> page :
> (...)

This is correct.

> the patch is called : unified patch for Linux 2.4.22 (i2c-2.8.2)
> then I recompiled my kernel, with all i2c software in modules
> it did well
> 
> then I downloaded : lm_sensors-2.8.3.tar.gz (FTP)

This is likely to cause trouble. lm-sensors-2.8.3 needs a few IDs that
are not in i2c-2.8.2.

> untared it and simply typed 'make' (as root) in the created
> lm-sensors directory, the compilation seemed to go well until I get
> a compilation error with one chip module wt**.c , sorry I did not
> remember the exact error message bu it told that there was one
> undefined variable

More likely undefined constant in w83l785ts.c.

> my config is a MSI K7N2delta-l ( chip nforce2 ) and a cpu : AMD
> duron
> 
> do you know this problem ? may be there was an option to pass with
> 'make' command that I would have forgotten, may be when reading what
> I have done you will obviously notice that I have forgotten one step

You did the correct thing except that the versions of i2c and lm_sensors
don't match.

You can do one of the following things to solve the problem:

* Install lm_sensors 2.8.2 instead of 2.8.3.

* Manually copy a recent version of i2c-id.h to the correct place in
your kernel source tree (include/linux). You can get a bleeding-edge
version of that file here:
http://www2.lm-sensors.nu/~lm78/cvs/i2c/kernel/i2c-id.h
No need to recompile your kernel, just retry compiling lm_sensors and it
should be fine.

* Use "make -k", which will ignore the error. Only the w83l785ts driver
should be missing, so unless you need this paricular one, you won't
care.

My personal choice would go to solution #2.

Let us know how it goes.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
