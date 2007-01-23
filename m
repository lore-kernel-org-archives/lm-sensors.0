From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 23 Jan 2007 08:35:04 +0000
Subject: [lm-sensors] sensors and i2cdump disagree on bus number
Message-Id: <20070123093504.1ff1306d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0701222114x22dfb5bcn255c300df4fd3a84@mail.gmail.com>
In-Reply-To: <191fb4ca0701222114x22dfb5bcn255c300df4fd3a84@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Mon, 22 Jan 2007 21:14:57 -0800, Juerg Haefliger wrote:
> Hi all,
> 
> When running sensors (2.10.1) I get the following adapter information:
> emc6d102-i2c-1-2e
> Adapter: SMBus nForce2 adapter at 4c40
> 
> And i2cdump prints the following:
>   Installed I2C busses:
>     i2c-5       i2c             NVIDIA i2c adapter 2 at 0:05.0
>     i2c-4       i2c             NVIDIA i2c adapter 1 at 0:05.0
>     i2c-3       i2c             NVIDIA i2c adapter 0 at 0:05.0
>     i2c-2       i2c             ivtv i2c driver #0
>     i2c-1       smbus           SMBus nForce2 adapter at 4c40
>     i2c-0       smbus           SMBus nForce2 adapter at 4c00
> 
> But in order to dump the register content of the emc6d102 I have to scan bus
> 0:
> 
> jabba:/home/juergh# i2cdump 0 0x2e
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x2e, mode byte
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 20: 00 79 c1 c2 be 80 29 31 46 0b ff ff ff ff ff ff    .y????)1F?......
> 30: 55 ff ff 00 00 00 00 00 00 00 00 00 00 00 5c 8a    U.............\?
> 40: 05 91 40 00 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f    ??@...........??
> 50: 81 7f 81 7f ff ff ff ff ff ff ff ff 42 62 62 cb    ????........Bbb?
> 60: cb db e0 00 55 80 80 5a 5a 3c 64 64 4d 40 40 00    ???.U??ZZ<ddM@@.
> 70: 55 ff ff 09 09 09 09 09 09 00 10 00 40 00 ec 18    U..??????.?. at .??
> 80: 7e a4 0e 00 60 90 99 90 c1 00 4d 4d 0b 0b 0d 00    ~??.`????.MM???.
> 90: 04 04 04 04 0c 0c 0c 5a f1 c2 00 00 ff 00 ff 00    ???????Z??......
> a0: 00 00 0c 00 02 00 00 0b 0b fe ff fe ff ff ff ff    ..?.?..???.?....
> b0: ff 00 00 00 00 00 28 28 0e 0e 2b 2b 00 00 00 00    ......((??++....
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 
> Scanning bus 1 on the other hand returns all FFs:
> 
> jabba:/home/juergh# i2cdump 1 0x2c
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-1, address 0x2c, mode byte
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

Which kernel is this? 2.5 and early 2.6 kernels are known for this
behavior. It was fixed in 2.6.4. I guess you're using something more
recent though.

Is this bug reproducible, or did it only happen to you once?

When it happens, please run "ls -l /dev/i2c*" (or /dev/i2c/* if your
system uses this naming scheme.) I suspect that you have /dev/i2c-1
using minor 0 and /dev/i2c-0 using minor 1.

-- 
Jean Delvare

