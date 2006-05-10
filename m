From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 10 May 2006 17:06:08 +0000
Subject: [lm-sensors] netfinity 6000r crash running sensors-detect
Message-Id: <44621D80.9050706@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <a0fb11cc0604031304m792d8a8oef1f1a81c10e23ad@mail.gmail.com>
In-Reply-To: <a0fb11cc0604031304m792d8a8oef1f1a81c10e23ad@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark Lybarger wrote:
> I seem to have gotten by the scanning.  Here's your requested output. 
> Sensors still doesn't work, but at least it doesn't crash my machine:
> 
> arabica mark # lspci -xxx
> 00:00.0 Host bridge: Broadcom CNB20HE Host Bridge (rev 21)

Hmm I need this line:
00:0f.0 ISA bridge: Broadcom OSB4 South Bridge (rev 4f

Or similar one... Please include it in later mail

> 
> arabica mark # modprobe i2c-dev
> arabica mark # modprobe i2c-piix4
> arabica mark # i2cdump -y 0 0x50
> No size specified (using byte-data access)
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 
> arabica mark # i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c/0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n] Y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
> 10: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
> 20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
> 30: 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f
> 40: 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f
> 50: UU UU UU UU UU UU UU UU 58 59 5a 5b 5c 5d 5e 5f
> 60: 60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f
> 70: 70 71 72 73 74 75 76 77
> 

Hmm this means smbus is not working at all.

I guess you did all steps just after clean start?

Thanks

Regards
Rudolf

