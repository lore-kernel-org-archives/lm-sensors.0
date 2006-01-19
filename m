From: stevenkaratnyk@rogers.com (Steven Karatnyk)
Date: Thu, 19 Jan 2006 05:27:28 +0000
Subject: [lm-sensors] seeking a W83687THF patch for 2.6.15 (re: ticket
Message-Id: <43CF2340.10200@rogers.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <43BDFEEE.4070408@rogers.com>
In-Reply-To: <43BDFEEE.4070408@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

Mark M. Hoffman wrote:
> Steven, you can use the following command to see which libraries would be
> used by sensors:
>
> 	$ ldd `which sensors`
>
> E.g., mine says this:
>
> 	$ ldd `which sensors`
>         	linux-gate.so.1 =>  (0xffffe000)
>         	libsensors.so.3 => /usr/local/lib/libsensors.so.3 (0xb7f65000)
>         	libc.so.6 => /lib/tls/libc.so.6 (0xb7e22000)
>         	libm.so.6 => /lib/tls/libm.so.6 (0xb7dff000)
>         	libsysfs.so.1 => /usr/lib/libsysfs.so.1 (0xb7df5000)
>         	/lib/ld-linux.so.2 (0xb7f9f000)

Now there's a neat trick :)

As user I get:

$ ldd `which sensors`
linux-gate.so.1 => (0xffffe000)
libsensors.so.3 => /usr/local/lib/libsensors.so.3 (0x40017000)
libc.so.6 => /lib/tls/libc.so.6 (0x40065000)
libm.so.6 => /lib/tls/libm.so.6 (0x40184000)
libsysfs.so.1 => /lib/libsysfs.so.1 (0x401aa000)
/lib/ld-linux.so.2 (0x40000000)

As root, there is a slight difference (libsensors.so.3):

# ldd `which sensors`
linux-gate.so.1 => (0xffffe000)
libsensors.so.3 => /usr/local/lib/libsensors.so.3 (0x40018000)
libc.so.6 => /lib/tls/libc.so.6 (0x40065000)
libm.so.6 => /lib/tls/libm.so.6 (0x40184000)
libsysfs.so.1 => /lib/libsysfs.so.1 (0x401aa000)
/lib/ld-linux.so.2 (0x40000000)

Thanks, Steven


