From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 22 Feb 2007 16:41:14 +0000
Subject: [lm-sensors] mcp61 sensors support
Message-Id: <20070222174114.3ee17450.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <9ef864c50702182307q4364770cj53c6dbab30fcd887@mail.gmail.com>
In-Reply-To: <9ef864c50702182307q4364770cj53c6dbab30fcd887@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Thomas,

On Wed, 21 Feb 2007 22:02:31 -0500, Thomas Garner wrote:
> > That being said, there are no sensors on the SMBus, only one EEPROM. If
> > there are sensors on your system, they have to be somewhere else, maybe
> > in the Super-I/O chip. Did you try running a recent version of
> > sensors-detect already? What did it find?
> 
> (...)
> [root at ns ~]# sensors-detect
> # sensors-detect revision 4171 (2006-09-24 03:37:01 -0700)
> 
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
> (...)
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no): y
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `ITE'...                                      Yes
> Found unknown chip with ID 0x8726
>     (logical device 4 has address 0x290, could be sensors)

Looks like the latest Super-I/O from ITE, the IT8726F, which we do not
support yet. At first sight it appears to be very similar to the
IT8716F, which we do support since 2.6.18, so it should be possible to
add support to the it87 driver easily. There are some technical details
which are unclear in the datasheet though, so I'm waiting a bit before
going on.

Do you have the possibility to recompile your kernel and lm_sensors
with some patches applied?

-- 
Jean Delvare

