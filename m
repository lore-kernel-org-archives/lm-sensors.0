From: Clemens Ladisch <clemens@ladisch.de>
Date: Thu, 19 Nov 2009 13:09:57 +0000
Subject: Re: [lm-sensors] amd phenom ii temp
Message-Id: <4B0543A5.9090308@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <379c0ddc0911190214x7808a9f9m47349413351ffa0c@mail.gmail.com>
In-Reply-To: <379c0ddc0911190214x7808a9f9m47349413351ffa0c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sergej wrote:
> I have problems running lm_sensors on my computer (ASUS M4A79T Deluxe
> with amd phenom II 965BE C3). I can't get any temperature readings
> from the CPU.

Because the sensor driver for your CPU is not in the kernel.

> I've tried to read in many forums, and partly in the mail-list archive
> here. Then only thing I have concluded from this is that I have to
> patch the k8temp driver (or change it if I understood everything right).

Yes; there also exist several patches for new "k10temp" drivers.
Anyway,
1) Save the patch to a file.
2) Get the kernel source (usually a package named "kernel-source-2.6.xx"
   with the correct kernel configuration.
3) Go to the kernel source's top directory, and run
      patch < /where/you/have/put/the/patchfile
4) Recompile the kernel: "make"
5) Install the kernel.

Steps 2+5 are dependent on your distribution; you should look into your
distribution's documentation for detailed instructions.

=====

Jean, who is the hwmon maintainer?
Or where should new drivers be submitted?


Best regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
