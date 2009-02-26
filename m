From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 Feb 2009 15:09:59 +0000
Subject: Re: [lm-sensors] W83667HG driver test for in6 and temp3
Message-Id: <20090226160959.016e3f9b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <29CFBC9A3FDC81418F5FACEEC8970E0020AE12@ntshml01.nuvoton.com>
In-Reply-To: <29CFBC9A3FDC81418F5FACEEC8970E0020AE12@ntshml01.nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

On Wed, 25 Feb 2009 11:18:23 -0500, Michael Hampton wrote:
> I applied this patch to my current Fedora 10 kernel but the patched
> module fails to load:
> root@underground ~ # modprobe w83627ehf
> FATAL: Error inserting w83627ehf
> (/lib/modules/2.6.27.15-170.2.24.fc10.x86_64/kernel/drivers/hwmon/w83627ehf.ko):
> No such device
> 
> I haven't tried with a vanilla kernel yet. I don't usually run them.
> 
> Interestingly, sensors-detect says the device has a different ID:

Different from what? 

> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       Yes
> Found unknown chip with ID 0xa513
>     (logical device B has address 0x290, could be sensors)
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Trying family `ITE'...                                      No

The driver accepts IDs 0xa510 to 0xa51f so it should be OK.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
