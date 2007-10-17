From: "KEITH ROMBERG" <k_romberg@msn.com>
Date: Wed, 17 Oct 2007 01:38:23 +0000
Subject: Re: [lm-sensors] Compaq EVO W8000 Sensor/Chip Support
Message-Id: <BAY117-F3491CE2D3C705AD967FC29939D0@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============9128147359396610920=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1192538331.4059.17.camel@tiger.atd.ucar.edu>
In-Reply-To: <1192538331.4059.17.camel@tiger.atd.ucar.edu>
To: lm-sensors@vger.kernel.org

--===============9128147359396610920==
Content-Type: text/plain; format=flowed

OK, I have now installed the latest version of lm_sensors 2.10.4.  Here is 
the snip from sensors-detect:

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found `SMSC LPC47B357 Super IO'
    (no information available)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Now i ran the prog/hotplug/unhide_ICH_SMBus and here is the output:

Enabling SMBus PCI device ...
Rescanning the bus ...
Loading i2c-i801 ...
00:1f.3 SMBus: Intel Corporation 82801BA/BAM SMBus (rev 04)
Done!
Remember: system suspend/resume is no longer safe to use.

I do not suspend and/or resume the machine, so I guess things will be 
OK......

Rerunning sensors-detect found everything :)

[root@scatha lm_sensors-2.10.4]# sensors
adm1023-i2c-0-18
Adapter: SMBus I801 adapter at fc00
Board Temp:
             +43������C  (low  =   -55������C, high =  +127������C)
CPU Temp:    +47������C  (low  =   -55������C, high =   +61������C)

adm1023-i2c-0-4c
Adapter: SMBus I801 adapter at fc00
Board Temp:
             +42������C  (low  =   -55������C, high =  +127������C)
CPU Temp:    +48������C  (low  =   -55������C, high =   +61������C)

Thanks for your help Juergh!!!  Once again you helped out.  Last time was 
the IPMI sensors on my Intel SHSR server.

Keith




--===============9128147359396610920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============9128147359396610920==--
