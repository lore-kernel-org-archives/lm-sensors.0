From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: Follow-UP to ticket 1578 as requested
Message-Id: <20040218231817.622fc9df.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1076891110.6884.10.camel@dumbo.whgl.uni-frankfurt.de>
In-Reply-To: <1076891110.6884.10.camel@dumbo.whgl.uni-frankfurt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hello Jean,
> 
> Sorry, it took me soem time, but I was kinda busy and involved with
> some studying etc. - anyway:
> 
> The libs are in place and ldd sensors is linked against
> libsensors.so.2
> 
> Maybe the followign helps, it's some info on libsensors.so.2:

In fact it doesn't. More interesting would be "ls -l
/usr/lib/libsensors* /usr/local/lib/libsensors*".

For example, on my system, it returns:

ls: /usr/lib/libsensors*: No such file or directory
-rw-r--r--    1 root     root       147412 Feb 13 19:03 /usr/local/lib/libsensors.a
lrwxrwxrwx    1 root     root           15 Feb 13 19:03 /usr/local/lib/libsensors.so -> libsensors.so.3
lrwxrwxrwx    1 root     root           19 Dec 20 09:43 /usr/local/lib/libsensors.so.1 -> libsensors.so.1.4.0
-rw-r--r--    1 root     root        84584 Feb 28  2002 /usr/local/lib/libsensors.so.1.2.0
-rw-r--r--    1 root     root        93341 Nov  9  2002 /usr/local/lib/libsensors.so.1.2.1
-rw-r--r--    1 root     root        95994 Dec 20 09:43 /usr/local/lib/libsensors.so.1.3.0
-rw-r--r--    1 root     root       106328 Jun  8  2003 /usr/local/lib/libsensors.so.1.4.0
lrwxrwxrwx    1 root     root           19 Nov  5 22:04 /usr/local/lib/libsensors.so.2 -> libsensors.so.2.0.2
-rw-r--r--    1 root     root       111703 Aug  4  2003 /usr/local/lib/libsensors.so.2.0.0
-rw-r--r--    1 root     root       118168 Oct 27 21:02 /usr/local/lib/libsensors.so.2.0.1
-rw-r--r--    1 root     root       120216 Nov  5 22:04 /usr/local/lib/libsensors.so.2.0.2
lrwxrwxrwx    1 root     root           19 Feb 13 19:03 /usr/local/lib/libsensors.so.3 -> libsensors.so.3.0.2
-rw-r--r--    1 root     root       141081 Nov 29 14:16 /usr/local/lib/libsensors.so.3.0.0
-rw-r--r--    1 root     root       142622 Jan 31 19:53 /usr/local/lib/libsensors.so.3.0.1
-rw-r--r--    1 root     root       143038 Feb 13 19:03 /usr/local/lib/libsensors.so.3.0.2

(The list is long because, as a lm_sensors developer, I have all
versions of the lib since I started working on the project; you should
have far fewer than that.)

and on my system, "ldd $(which sensors)" says:
        libsensors.so.3 => /usr/local/lib/libsensors.so.3 (0x40016000)
        libc.so.6 => /lib/libc.so.6 (0x40059000)
        libm.so.6 => /lib/libm.so.6 (0x4017a000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)

So you can see that it links to /usr/local/lib/libsensors.so.3, which is
a link to /usr/local/lib/libsensors.so.3.0.2. So the library used is
version 3.0.2.

Please do the same on your system. I think that for lm_sensors 2.8.1,
the correct library is 2.0.1.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
