From: Jeff Rickman <jrickman@myamigos.us>
Date: Sun, 08 May 2011 11:19:11 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <4DC67C2F.8060107@myamigos.us>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050208040301000300050808"
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------050208040301000300050808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello jean,

On 5/8/2011 1:27 AM, Jean Delvare wrote:
> Hi Jeff,
>
> On Sat, 07 May 2011 23:09:40 -0500, Jeff Rickman wrote:
>> I just tried out the "i8k.c" code from the link shown above. I still get
>> a crash in Syslog and messages on the Console when loading the new
>> module. The machine still runs so the crash doesn't appear to be "fatal".
>
> Well you had already tried exactly this version, hadn't you?
>
>>
>> My testing steps:
>> (1) Completely remove the "i8k" module supplied by Fedora to a "safe"
>> location. It is not being used on my machine per "lsmod".
>
> Did you try loading this original i8k driver? Did it work? What are the
> contents of /proc/i8k then?
>
> If the original works and mine fails, please send me the two .ko files
> in private and I'll try to figure out how they differ. Even better if
> you can get the exact kernel sources used by Fedora to build your
> running kernel so that I can also compare the source code (the source
> file is drivers/misc/i8k.c in the kernel tree.)
>
>> (2) Run "depmod -a"
>> (3) Build the new "i8k" module, but leave it where it is built
>> (4) Reboot, just to be certain the legacy "i8k" module isn't being loaded
>> (5) Copy the new "i8k" module to /lib/modules/`uname
>> -r`/kernel/drivers/hwmon
>> (6) Run "depmod -a" again
>> (7) Run "modprobe -v i8k"
>
> Note that you could simply use insmod with full path to the new module,
> so you don't have to install it.
>
>> At this point I get Console messages and a crashdump to Syslog. See
>> attached text file for details.
>>
>> With the new "i8k" module loaded per "lsmod", a "lock up" occurs when
>> accessing the I2C bus in "sensors-detect" version 5946. A "ctrl-C" is
>> required to get the script running again. Output at the lock up follows:
>>
>> Using driver 'i2c-i801' for device 0000:00:1f.3 Intel 82801EB ICH5
>> Module i2c-dev loaded successfully.
>>
>> I can sit and wait on this output for minutes unless I issue a "ctrl-C"
>> to continue script processing. That is not normal behavior.
>
> With the kernel crash you got, it's nor surprising that anything
> related to kernel module loading or unloading will hang.
>
>> Harry, is your Dell machine a single CPU or a dual-CPU system? Also,
>> what Dell BIOS version are you using? I'm curious to know what is
>> different. My system has 2 physical Intel Xeon 3.0 GHz cpu that are also
>> hyperthreaded. My Dell BIOS is A07; "dmidecode" will reflect that in
>> "Handle 0x000" and so will a machine reboot. There is 2G of DRAM
>> onboard. I am running Fedora Core 14 x86_64. "uname -a" output follows:
>>
>> Linux xx.xx.xx.xx 2.6.35.12-90.fc14.x86_64 #1 SMP Fri Apr 22 16:01:29
>> UTC 2011 x86_64 x86_64 x86_64 GNU/Linux
>

[testing with original "i8k" module]
(1) Removed new "i8k" module from /lib/modules tree
(2) Checked "/proc/i8k". No such file or directory
(3) Copied original "i8k" module back to it's location in:
/lib/modules/`uname -r`/drivers/char
(4) Ran "depmod -a"
(5) Rebooted PC to obtain known stable state

After reboot...
(6) Checked "/proc/i8k". No such file or directory
(7) Checked "lsmod". "i8k" is not loaded
(8) Attempted to load original "i8k" but it crashed.
     Crash output is attached.
(9) Rechecked "/proc/i8k". No such file or directory
(10) Rebooted PC to return to known stable state

I sent along my "uname -a" output to Hans so he could locate the correct 
source files to send to you privately. I bet he can find the correct 
source code files and mail them faster than I can, but I will try.

As for the system kernel, I am running a "stock as delivered by Fedora" 
kernel; I did not do any recompiling or anything else to it. I loaded 
the following Fedora "packages" via "yum":

kernel-devel
kernel-headers
make
gcc

Those "packages" were all I needed to compile your "i8k.c" file using 
the "Makefile" also found in the same folder. Again, nothing special here.

--------------050208040301000300050808
Content-Type: text/plain;
 name="Even_More_Dell_Sensors_Testing.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="Even_More_Dell_Sensors_Testing.txt"

W3BsYWNpbmcgb3JpZ2luYWwgZHJpdmVyIGJhY2sgd2hlcmUgaXQgY2FtZSBmcm9tIHRoZW4g
bG9hZGluZyBpdF0NCiANCltyb290QFhYIGRyaXZlcnNdIyBtb2Rwcm9iZSAtdiBpOGsNCmlu
c21vZCAvbGliL21vZHVsZXMvMi42LjM1LjEyLTkwLmZjMTQueDg2XzY0L2tlcm5lbC9kcml2
ZXJzL2NoYXIvaThrLmtvDQpTZWdtZW50YXRpb24gZmF1bHQNCiANCk1lc3NhZ2UgZnJvbSBz
eXNsb2dkQFhYIGF0IE1heSAgOCAwNTo1NTozMiAuLi4NCiBrZXJuZWw6WyAgMTUxLjczNDc1
M10gaW52YWxpZCBvcGNvZGU6IDAwMDAgWyMxXSBTTVANCltyb290QFhYIGRyaXZlcnNdIw0K
TWVzc2FnZSBmcm9tIHN5c2xvZ2RAWFggYXQgTWF5ICA4IDA1OjU1OjMyIC4uLg0KIGtlcm5l
bDpbICAxNTEuNzM0ODMwXSBsYXN0IHN5c2ZzIGZpbGU6IC9zeXMvZGV2aWNlcy9zeXN0ZW0v
Y3B1L2NwdTEvY3B1ZnJlcS9zY2FsaW5nX3NldHNwZWVkDQogDQpNZXNzYWdlIGZyb20gc3lz
bG9nZEBYWCBhdCBNYXkgIDggMDU6NTU6MzIgLi4uDQoga2VybmVsOlsgIDE1MS43MzU2Nzhd
IFN0YWNrOg0KIA0KTWVzc2FnZSBmcm9tIHN5c2xvZ2RAWFggYXQgTWF5ICA4IDA1OjU1OjMy
IC4uLg0KIGtlcm5lbDpbICAxNTEuNzM1Njc4XSBDYWxsIFRyYWNlOg0KIA0KTWVzc2FnZSBm
cm9tIHN5c2xvZ2RAWFggYXQgTWF5ICA4IDA1OjU1OjMyIC4uLg0KIGtlcm5lbDpbICAxNTEu
NzM1Njc4XSBDb2RlOiA1MiA4YiA1OCAwNCA4YiA0OCAwOCA4YiA1MCAwYyA4YiA3MCAxMCA4
YiA3OCAxNCA1OCBlNiBiMiBlNiA4NCA0OCA4NyAwNCAyNCA4OSA1OCAwNCA4OSA0OCAwOCA4
OSA1MCAwYyA4OSA3MCAxMCA4OSA3OCAxNCA1YSA4OSAxMCA8OWY+IGMxIGU4IDA4IDgzIGUw
IDAxIDg1IGMwIGJhIGVhIGZmIGZmIGZmIDc1IDBmIDQxIDhiIDA4IDY2IDgzDQogDQpbcm9v
dEBYWCBkcml2ZXJzXSMgdGFpbCAtNTAgL3Zhci9sb2cvbWVzc2FnZXMNCk1heSAgOCAwNTo1
MzozMSBYWCBzbWFydGRbMTQ5NV06IERldmljZTogL2Rldi9zZGEgW1NBVF0sIGVuYWJsZWQg
U01BUlQgQXR0cmlidXRlIEF1dG9zYXZlLg0KTWF5ICA4IDA1OjUzOjMxIFhYIHNtYXJ0ZFsx
NDk1XTogRGV2aWNlOiAvZGV2L3NkYSBbU0FUXSwgZW5hYmxlZCBTTUFSVCBBdXRvbWF0aWMg
T2ZmbGluZSBUZXN0aW5nLg0KTWF5ICA4IDA1OjUzOjMxIFhYIHNtYXJ0ZFsxNDk1XTogRGV2
aWNlOiAvZGV2L3NkYSBbU0FUXSwgaXMgU01BUlQgY2FwYWJsZS4gQWRkaW5nIHRvICJtb25p
dG9yIiBsaXN0Lg0KTWF5ICA4IDA1OjUzOjMxIFhYIHNtYXJ0ZFsxNDk1XTogTW9uaXRvcmlu
ZyAxIEFUQSBhbmQgMCBTQ1NJIGRldmljZXMNCk1heSAgOCAwNTo1MzozMiBYWCBzbWFydGRb
MTQ5NV06IERldmljZTogL2Rldi9zZGEgW1NBVF0sIGluaXRpYWwgVGVtcGVyYXR1cmUgaXMg
MzQgQ2Vsc2l1cyAoTWluL01heCA/Py8zNCkNCk1heSAgOCAwNTo1MzozMiBYWCBzbWFydGRb
MTQ5N106IHNtYXJ0ZCBoYXMgZm9yaygpZWQgaW50byBiYWNrZ3JvdW5kIG1vZGUuIE5ldyBQ
SUQ9MTQ5Ny4NCk1heSAgOCAwNTo1Mzo0NCBYWCBrZXJuZWw6IFsgICA0NC4wNTAxMTNdIHJl
YWRhaGVhZC1jb2xsZWN0b3I6IHNvcnRpbmcNCk1heSAgOCAwNTo1Mzo0NCBYWCBrZXJuZWw6
IFsgICA0NC4xODk0NDBdIHJlYWRhaGVhZC1jb2xsZWN0b3I6IGZpbmlzaGVkDQpNYXkgIDgg
MDU6NTM6NDUgWFggbnRwZFsxNDAzXTogRGVmZXJyaW5nIEROUyBmb3IgMC5mZWRvcmEucG9v
bC5udHAub3JnIDENCk1heSAgOCAwNTo1Mzo0NSBYWCBudHBkWzE0MDNdOiAwLjAuMC4wIGMw
MTYgMDYgcmVzdGFydA0KTWF5ICA4IDA1OjUzOjQ1IFhYIG50cGRbMTQwM106IDAuMC4wLjAg
YzAxMiAwMiBmcmVxX3NldCBrZXJuZWwgLTM1LjU0MyBQUE0NCk1heSAgOCAwNTo1Mzo0NyBY
WCBudHBkX2ludHJlc1sxNTMwXTogRE5TIDAuZmVkb3JhLnBvb2wubnRwLm9yZyAtPiAxODQu
MTA1LjE4Mi43DQpNYXkgIDggMDU6NTU6MzIgWFgga2VybmVsOiBbICAxNTEuNzM0NzUzXSBp
bnZhbGlkIG9wY29kZTogMDAwMCBbIzFdIFNNUA0KTWF5ICA4IDA1OjU1OjMyIFhYIGtlcm5l
bDogWyAgMTUxLjczNDgzMF0gbGFzdCBzeXNmcyBmaWxlOiAvc3lzL2RldmljZXMvc3lzdGVt
L2NwdS9jcHUxL2NwdWZyZXEvc2NhbGluZ19zZXRzcGVlZA0KTWF5ICA4IDA1OjU1OjMyIFhY
IGtlcm5lbDogWyAgMTUxLjczNDg4Ml0gQ1BVIDMNCk1heSAgOCAwNTo1NTozMiBYWCBrZXJu
ZWw6IFsgIDE1MS43MzQ5MDJdIE1vZHVsZXMgbGlua2VkIGluOiBpOGsoKykgYWN0X3BvbGlj
ZSBjbHNfZmxvdyBjbHNfZncgY2xzX3UzMiBzY2hfdGJmIHNjaF9wcmlvIHNjaF9odGIgc2No
X2hmc2Mgc2NoX2luZ3Jlc3Mgc2NoX3NmcSB4dF90aW1lIHh0X2Nvbm5saW1pdCB4dF9yZWFs
bSBpcHRhYmxlX3JhdyB4dF9jb21tZW50IHh0X3JlY2VudCB4dF9wb2xpY3kgaXB0X1VMT0cg
aXB0X1JFRElSRUNUIGlwdF9ORVRNQVAgaXB0X01BU1FVRVJBREUgaXB0X0VDTiBpcHRfZWNu
IGlwdF9DTFVTVEVSSVAgaXB0X2FoIGlwdF9hZGRydHlwZSBuZl9uYXRfdGZ0cCBuZl9uYXRf
c25tcF9iYXNpYyBuZl9uYXRfc2lwIG5mX25hdF9wcHRwIG5mX25hdF9wcm90b19ncmUgbmZf
bmF0X2lyYyBuZl9uYXRfaDMyMyBuZl9uYXRfZnRwIG5mX25hdF9hbWFuZGEgdHNfa21wIG5m
X2Nvbm50cmFja19hbWFuZGEgbmZfY29ubnRyYWNrX3NhbmUgbmZfY29ubnRyYWNrX3RmdHAg
bmZfY29ubnRyYWNrX3NpcCBuZl9jb25udHJhY2tfcHJvdG9fc2N0cCBuZl9jb25udHJhY2tf
cHB0cCBuZl9jb25udHJhY2tfcHJvdG9fZ3JlIG5mX2Nvbm50cmFja19uZXRsaW5rIG5mX2Nv
bm50cmFja19uZXRiaW9zX25zIG5mX2Nvbm50cmFja19pcmMgbmZfY29ubnRyYWNrX2gzMjMg
bmZfY29ubnRyYWNrX2Z0cCB4dF9UUFJPWFkgbmZfdHByb3h5X2NvcmUgeHRfdGNwbXNzIHh0
X3BrdHR5cGUgeHRfcGh5c2RldiB4dF9vd25lciB4dF9ORlFVRVVFIHh0X05GTE9HIG5mbmV0
bGlua19sb2cgeHRfbXVsdGlwb3J0IHh0X21hcmsgeHRfbWFjIHh0X2xpbWl0IHh0X2xlbmd0
aCB4dF9pcHJhbmdlIHh0X2hlbHBlciB4dF9oYXNobGltaXQgeHRfRFNDUCB4dF9kc2NwIHh0
X2RjY3AgeHRfY29ubm1hcmsgeHRfQ0xBU1NJRlkgaXB0X0xPRyBpcHRhYmxlX25hdCBuZl9u
YXQgaXB0YWJsZV9tYW5nbGUgbmZuZXRsaW5rIHA0X2Nsb2NrbW9kIGZyZXFfdGFibGUgc3Bl
ZWRzdGVwX2xpYiBlMTAwMCBpVENPX3dkdCBpVA0KTWF5ICA4IDA1OjU1OjMyIFhYIGtlcm5l
bDogQ09fdmVuZG9yX3N1cHBvcnQgc2hwY2hwIGU3NTJ4X2VkYWMgaTJjX2k4MDEgc2VyaW9f
cmF3IGVkYWNfY29yZSBkY2RiYXMgbWljcm9jb2RlIGZpcmV3aXJlX29oY2kgZmlyZXdpcmVf
Y29yZSBjcmNfaXR1X3Qgbm91dmVhdSB0dG0gZHJtX2ttc19oZWxwZXIgZHJtIGkyY19hbGdv
X2JpdCB2aWRlbyBvdXRwdXQgaTJjX2NvcmUgW2xhc3QgdW5sb2FkZWQ6IG1wZXJmXQ0KTWF5
ICA4IDA1OjU1OjMyIFhYIGtlcm5lbDogWyAgMTUxLjczNTY3OF0NCk1heSAgOCAwNTo1NToz
MiBYWCBrZXJuZWw6IFsgIDE1MS43MzU2NzhdIFBpZDogMTY3NCwgY29tbTogbW9kcHJvYmUg
Tm90IHRhaW50ZWQgMi42LjM1LjEyLTkwLmZjMTQueDg2XzY0ICMxIDBVNzU2NS9QcmVjaXNp
b24gV29ya1N0YXRpb24gNjcwICAgDQpNYXkgIDggMDU6NTU6MzIgWFgga2VybmVsOiBbICAx
NTEuNzM1Njc4XSBSSVA6IDAwMTA6WzxmZmZmZmZmZmEwM2Y3MDQxPl0gIFs8ZmZmZmZmZmZh
MDNmNzA0MT5dIGk4a19zbW0rMHg0MS8weDY1IFtpOGtdDQpNYXkgIDggMDU6NTU6MzIgWFgg
a2VybmVsOiBbICAxNTEuNzM1Njc4XSBSU1A6IDAwMTg6ZmZmZjg4MDA3ZDA0NWVhMCAgRUZM
QUdTOiAwMDAxMDI0Ng0KTWF5ICA4IDA1OjU1OjMyIFhYIGtlcm5lbDogWyAgMTUxLjczNTY3
OF0gUkFYOiBmZmZmODgwMDdkMDQ1ZWI4IFJCWDogMDAwMDAwMDAwMDAwMDAwMCBSQ1g6IDAw
MDAwMDAwMDAwMDAwMDANCk1heSAgOCAwNTo1NTozMiBYWCBrZXJuZWw6IFsgIDE1MS43MzU2
NzhdIFJEWDogMDAwMDAwMDAwMDAwZmVhMyBSU0k6IDAwMDAwMDAwMDAwMDAwMDAgUkRJOiAw
MDAwMDAwMDAwMDAwMDAwDQpNYXkgIDggMDU6NTU6MzIgWFgga2VybmVsOiBbICAxNTEuNzM1
Njc4XSBSQlA6IGZmZmY4ODAwN2QwNDVlYTggUjA4OiBmZmZmODgwMDdkMDQ1ZWI4IFIwOTog
MDAwMDAwMDAwMDAwZmVhMw0KTWF5ICA4IDA1OjU1OjMyIFhYIGtlcm5lbDogWyAgMTUxLjcz
NTY3OF0gUjEwOiBmZmZmZmZmZmEwM2Y3ZDEwIFIxMTogMDAwMDAwMDAwMDAwMDAwMCBSMTI6
IDAwMDAwMDAwMDAwMDAwMDANCk1heSAgOCAwNTo1NTozMiBYWCBrZXJuZWw6IFsgIDE1MS43
MzU2NzhdIFIxMzogMDAwMDAwMDAwMGRiODA0MCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDAgUjE1
OiAwMDAwMDAwMDAwZGIxNmMwDQpNYXkgIDggMDU6NTU6MzIgWFgga2VybmVsOiBbICAxNTEu
NzM1Njc4XSBGUzogIDAwMDA3ZjU2Zjk3NDc3MjAoMDAwMCkgR1M6ZmZmZjg4MDAwMjBjMDAw
MCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQpNYXkgIDggMDU6NTU6MzIgWFgga2Vy
bmVsOiBbICAxNTEuNzM1Njc4XSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAw
MDAwMDAwMDgwMDUwMDNiDQpNYXkgIDggMDU6NTU6MzIgWFgga2VybmVsOiBbICAxNTEuNzM1
Njc4XSBDUjI6IDAwMDAwMDNhMTM2ZTEyMDAgQ1IzOiAwMDAwMDAwMDdkOTBjMDAwIENSNDog
MDAwMDAwMDAwMDAwMDZlMA0KTWF5ICA4IDA1OjU1OjMyIFhYIGtlcm5lbDogWyAgMTUxLjcz
NTY3OF0gRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERSMTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6
IDAwMDAwMDAwMDAwMDAwMDANCk1heSAgOCAwNTo1NTozMiBYWCBrZXJuZWw6IFsgIDE1MS43
MzU2NzhdIERSMzogMDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZjBmZjAgRFI3
OiAwMDAwMDAwMDAwMDAwNDAwDQpNYXkgIDggMDU6NTU6MzIgWFgga2VybmVsOiBbICAxNTEu
NzM1Njc4XSBQcm9jZXNzIG1vZHByb2JlIChwaWQ6IDE2NzQsIHRocmVhZGluZm8gZmZmZjg4
MDA3ZDA0NDAwMCwgdGFzayBmZmZmODgwMDdlNDhkZDAwKQ0KTWF5ICA4IDA1OjU1OjMyIFhY
IGtlcm5lbDogWyAgMTUxLjczNTY3OF0gU3RhY2s6DQpNYXkgIDggMDU6NTU6MzIgWFgga2Vy
bmVsOiBbICAxNTEuNzM1Njc4XSAgZmZmZmZmZmZhMDNmYjAwMCBmZmZmODgwMDdkMDQ1ZWQ4
IGZmZmZmZmZmYTAzZjcxZDIgMDAwMDAwMDAwMDAwZmVhMw0KTWF5ICA4IDA1OjU1OjMyIFhY
IGtlcm5lbDogWyAgMTUxLjczNTY3OF0gPDA+IDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAw
MDAwMDAwMCBmZmZmZmZmZmEwM2Y3MjFjIGZmZmY4ODAwN2QwNDVmMDgNCk1heSAgOCAwNTo1
NTozMiBYWCBrZXJuZWw6IFsgIDE1MS43MzU2NzhdIDwwPiBmZmZmZmZmZmEwM2ZiMGE3IGZm
ZmY4ODAwN2QwNDVmMjggZmZmZmZmZmY4MTA2YWU1MCBmZmZmZmZmZmEwM2ZiMDAwDQpNYXkg
IDggMDU6NTU6MzIgWFgga2VybmVsOiBbICAxNTEuNzM1Njc4XSBDYWxsIFRyYWNlOg0KTWF5
ICA4IDA1OjU1OjMyIFhYIGtlcm5lbDogWyAgMTUxLjczNTY3OF0gIFs8ZmZmZmZmZmZhMDNm
YjAwMD5dID8gaThrX2luaXQrMHgwLzB4MWFkIFtpOGtdDQpNYXkgIDggMDU6NTU6MzIgWFgg
a2VybmVsOiBbICAxNTEuNzM1Njc4XSAgWzxmZmZmZmZmZmEwM2Y3MWQyPl0gaThrX2dldF9k
ZWxsX3NpZ25hdHVyZSsweDI4LzB4NDggW2k4a10NCk1heSAgOCAwNTo1NTozMiBYWCBrZXJu
ZWw6IFsgIDE1MS43MzU2NzhdICBbPGZmZmZmZmZmYTAzZjcyMWM+XSA/IGk4a19nZXRfZG1p
X2RhdGErMHhlLzB4MmMgW2k4a10NCk1heSAgOCAwNTo1NTozMiBYWCBrZXJuZWw6IFsgIDE1
MS43MzU2NzhdICBbPGZmZmZmZmZmYTAzZmIwYTc+XSBpOGtfaW5pdCsweGE3LzB4MWFkIFtp
OGtdDQpNYXkgIDggMDU6NTU6MzIgWFgga2VybmVsOiBbICAxNTEuNzM1Njc4XSAgWzxmZmZm
ZmZmZjgxMDZhZTUwPl0gPyBfX2Jsb2NraW5nX25vdGlmaWVyX2NhbGxfY2hhaW4rMHg1Ni8w
eDYwDQpNYXkgIDggMDU6NTU6MzIgWFgga2VybmVsOiBbICAxNTEuNzM1Njc4XSAgWzxmZmZm
ZmZmZmEwM2ZiMDAwPl0gPyBpOGtfaW5pdCsweDAvMHgxYWQgW2k4a10NCk1heSAgOCAwNTo1
NTozMiBYWCBrZXJuZWw6IFsgIDE1MS43MzU2NzhdICBbPGZmZmZmZmZmODEwMDIxYTE+XSBk
b19vbmVfaW5pdGNhbGwrMHg1ZS8weDE1NQ0KTWF5ICA4IDA1OjU1OjMyIFhYIGtlcm5lbDog
WyAgMTUxLjczNTY3OF0gIFs8ZmZmZmZmZmY4MTA3ZDE1NT5dIHN5c19pbml0X21vZHVsZSsw
eGE2LzB4MWU0DQpNYXkgIDggMDU6NTU6MzIgWFgga2VybmVsOiBbICAxNTEuNzM1Njc4XSAg
WzxmZmZmZmZmZjgxMDA5Y2YyPl0gc3lzdGVtX2NhbGxfZmFzdHBhdGgrMHgxNi8weDFiDQpN
YXkgIDggMDU6NTU6MzIgWFgga2VybmVsOiBbICAxNTEuNzM1Njc4XSBDb2RlOiA1MiA4YiA1
OCAwNCA4YiA0OCAwOCA4YiA1MCAwYyA4YiA3MCAxMCA4YiA3OCAxNCA1OCBlNiBiMiBlNiA4
NCA0OCA4NyAwNCAyNCA4OSA1OCAwNCA4OSA0OCAwOCA4OSA1MCAwYyA4OSA3MCAxMCA4OSA3
OCAxNCA1YSA4OSAxMCA8OWY+IGMxIGU4IDA4IDgzIGUwIDAxIDg1IGMwIGJhIGVhIGZmIGZm
IGZmIDc1IDBmIDQxIDhiIDA4IDY2IDgzDQpNYXkgIDggMDU6NTU6MzIgWFgga2VybmVsOiBb
ICAxNTEuNzM1Njc4XSBSSVAgIFs8ZmZmZmZmZmZhMDNmNzA0MT5dIGk4a19zbW0rMHg0MS8w
eDY1IFtpOGtdDQpNYXkgIDggMDU6NTU6MzIgWFgga2VybmVsOiBbICAxNTEuNzM1Njc4XSAg
UlNQIDxmZmZmODgwMDdkMDQ1ZWEwPg0KTWF5ICA4IDA1OjU1OjMyIFhYIGtlcm5lbDogWyAg
MTUxLjc0MjI2MV0gLS0tWyBlbmQgdHJhY2UgOTYwNGRkMGMxNzZhM2E2OCBdLS0tDQpbcm9v
dEBYWCBkcml2ZXJzXSMNCiA=
--------------050208040301000300050808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------050208040301000300050808--
