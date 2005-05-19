From: alexander@isacson.info (Alexander Isacson)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: Adding support for vt1211 in kernel 2.6
Message-Id: <19430.192.176.33.6.1070351514.squirrel@firewall.isacson.dyndns.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <46951.192.176.33.6.1070287022.squirrel@firewall.isacson.dyndns.info>
In-Reply-To: <46951.192.176.33.6.1070287022.squirrel@firewall.isacson.dyndns.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ok. I'm willing to give this a shot.

It'll be for kernel 2.6.0-test11. Is it enough to just copy the vt1211
file from the lm_sensors package and modify it as described in you
patches?

Regards
/Alexander

>> Great job on the sensors package, I've had much use of it. Currently
>> I'm building a small UGV (unmanned ground vehicle) and I'm using
>> lm_sensors to monitor it's state.
>>
>> My problem is that I was forced to move to kernel 2.6 to get the
>> wireless lan card working properly. Unfortunatly there is no support
>> for the VT1211-super IO chip in that kernel.
>>
>> Is there a patch for it?
>
> No, there isn't. If you are wanting to port that driver to 2.4, you are
> very welcome. I have been writing a guide on how to do this. Get the
> following patches:
> http://www.ensicaen.ismra.fr/~delvare/devel/i2c/linux-2.6/linux-2.6.0-test9-i2c-doc-porting-clients.diff
> http://www.ensicaen.ismra.fr/~delvare/devel/i2c/linux-2.6/linux-2.6.0-test9-i2c-doc-sysfs-interface.diff
> http://www.ensicaen.ismra.fr/~delvare/devel/i2c/linux-2.6/linux-2.6.0-test9-i2c-doc-writing-clients.diff
> And apply them to your 2.6 kernel tree. Once your documentation is
> up-to-date, you should be able to start working.
>
> Porting drivers isn't really hard, although it helps a lot if you have
> already written such a driver. Feel free to ask questions here.
>
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
>
