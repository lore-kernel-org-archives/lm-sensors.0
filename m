From: DarKRaveR@verfeiert.org (DarKRaveR@verfeiert.org)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: Follow-UP to ticket 1578 as requested
Message-Id: <749282024.20040320165147@verfeiert.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1076891110.6884.10.camel@dumbo.whgl.uni-frankfurt.de>
In-Reply-To: <1076891110.6884.10.camel@dumbo.whgl.uni-frankfurt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

Okay, it took a very long time, I know, but I finally checked
everything. The used lib was /usr/local/lib/libsensors.so.2.0.0.
(The package claimed it was 2.8.1, but who knows).

I upgraded my kernel and  I just used newer packages of i2c and
lm_sensors from gentoo, which are not oficially released.
After that, the winbond gets used, the readings look okay in majority.

Just one fan is reporter at 0 rpm, and there's a couple fans as well
as one heat sensor missing and I got no clue, where to get the data.
:-)

Wednesday, February 18, 2004, 11:18:17 PM, you wrote:

>> Hello Jean,
>> 
>> Sorry, it took me soem time, but I was kinda busy and involved with
>> some studying etc. - anyway:
>> 
>> The libs are in place and ldd sensors is linked against
>> libsensors.so.2
>> 
>> Maybe the followign helps, it's some info on libsensors.so.2:

JD> In fact it doesn't. More interesting would be "ls -l
JD> /usr/lib/libsensors* /usr/local/lib/libsensors*".

JD> For example, on my system, it returns:

JD> ls: /usr/lib/libsensors*: No such file or directory
JD> -rw-r--r--    1 root     root       147412 Feb 13 19:03 /usr/local/lib/libsensors.a
JD> lrwxrwxrwx    1 root     root           15 Feb 13 19:03 /usr/local/lib/libsensors.so -> libsensors.so.3
JD> lrwxrwxrwx    1 root     root           19 Dec 20 09:43 /usr/local/lib/libsensors.so.1 -> libsensors.so.1.4.0
JD> -rw-r--r--    1 root     root        84584 Feb 28  2002 /usr/local/lib/libsensors.so.1.2.0
JD> -rw-r--r--    1 root     root        93341 Nov  9  2002 /usr/local/lib/libsensors.so.1.2.1
JD> -rw-r--r--    1 root     root        95994 Dec 20 09:43 /usr/local/lib/libsensors.so.1.3.0
JD> -rw-r--r--    1 root     root       106328 Jun  8  2003 /usr/local/lib/libsensors.so.1.4.0
JD> lrwxrwxrwx    1 root     root           19 Nov  5 22:04 /usr/local/lib/libsensors.so.2 -> libsensors.so.2.0.2
JD> -rw-r--r--    1 root     root       111703 Aug  4  2003 /usr/local/lib/libsensors.so.2.0.0
JD> -rw-r--r--    1 root     root       118168 Oct 27 21:02 /usr/local/lib/libsensors.so.2.0.1
JD> -rw-r--r--    1 root     root       120216 Nov  5 22:04 /usr/local/lib/libsensors.so.2.0.2
JD> lrwxrwxrwx    1 root     root           19 Feb 13 19:03 /usr/local/lib/libsensors.so.3 -> libsensors.so.3.0.2
JD> -rw-r--r--    1 root     root       141081 Nov 29 14:16 /usr/local/lib/libsensors.so.3.0.0
JD> -rw-r--r--    1 root     root       142622 Jan 31 19:53 /usr/local/lib/libsensors.so.3.0.1
JD> -rw-r--r--    1 root     root       143038 Feb 13 19:03 /usr/local/lib/libsensors.so.3.0.2

JD> (The list is long because, as a lm_sensors developer, I have all
JD> versions of the lib since I started working on the project; you should
JD> have far fewer than that.)

JD> and on my system, "ldd $(which sensors)" says:
JD>         libsensors.so.3 => /usr/local/lib/libsensors.so.3 (0x40016000)
JD>         libc.so.6 => /lib/libc.so.6 (0x40059000)
JD>         libm.so.6 => /lib/libm.so.6 (0x4017a000)
JD>         /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)

JD> So you can see that it links to /usr/local/lib/libsensors.so.3, which is
JD> a link to /usr/local/lib/libsensors.so.3.0.2. So the library used is
JD> version 3.0.2.

JD> Please do the same on your system. I think that for lm_sensors 2.8.1,
JD> the correct library is 2.0.1.




-- 
Best regards,
 DarKRaveR                            mailto:DarKRaveR@verfeiert.org
