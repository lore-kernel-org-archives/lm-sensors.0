From: Karl Schmidt <karl@xtronics.com>
Date: Mon, 21 Sep 2009 02:36:24 +0000
Subject: [lm-sensors] Intel 5500 temperature [moving to new thread... ]
Message-Id: <4AB6E6A8.9050307@xtronics.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020608080606090902040100"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020608080606090902040100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

CC off list karl@xtronics.com

I'm working on a Tyan S7002. It has an Intel 5500 (AKA tylersburg) chip on it with heatsink that 
runs hot. Digging into the details reveals that it throttles back if it gets too hot -

http://www.intel.com/assets/pdf/designguide/321330.pdf  -- see pg 18.

Is it possible to read the temperature of this chip?

I've attached some readouts..


More information at pg 159 of http://www.intel.com/Assets/PDF/datasheet/321328.pdf


--------------------------------------------------------------------------------
Karl Schmidt                                  EMail Karl@xtronics.com
Transtronics, Inc.                              WEB http://xtronics.com
3209 West 9th Street                             Ph (785) 841-3089
Lawrence, KS 66049                              FAX (785) 841-0434

42.7% of all statistics are made up on the spot.

--------------------------------------------------------------------------------

--------------020608080606090902040100
Content-Type: text/plain;
 name="modprobe.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modprobe.txt"

debian1:~# modprobe i2c-i801
debian1:~# modprobe ipmi-si
FATAL: Error inserting ipmi_si (/lib/modules/2.6.26-2-amd64/kernel/drivers/char/ipmi/ipmi_si.ko): No such device
debian1:~# modprobe lm78
debian1:~# modprobe w83793
debian1:~# modprobe ipmisensors
FATAL: Module ipmisensors not found.

--------------020608080606090902040100
Content-Type: text/plain;
 name="sensors3.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sensors3.conf"

# Sensors configuration file used by 'libsensors'

 # Here are configurations for Winbond W83793 chip.
chip "w83793-*"

#    label in0 "VCoreA"
#    label in1 "VCoreB"
#    label in2 "Vtt"
#    label in5 "+3.3V"
#    label in6 "+12V"
#    label in7 "+5V"
#    label in8 "5VSB"
#   label in9 "VBAT"
     label fan1 "CPU0fan J36"
     label fan2 "CPU1fan J37"
     label fan3 "fan J40"
     label fan4 "fan J41"
     label fan5 "fan J42"

      
    compute in6 12*@ ,  @/12

#   label temp1 "CPU1 Temp"
#   label temp2 "CPU2 Temp"

# fan1 adjustments examples

#   set fan1_min 1500

# temp2 limits examples

#   set temp2_max       45
#   set temp2_max_hyst  40

# ignore examples

#    ignore fan7
#   ignore temp5



chip "lm78-*" "lm79-*" "w83781d-*"

# These are as advised in the LM78 and LM79 data sheets, and used on almost
# any mainboard we have seen.


#    label in0 "VCore 1"
#    label in1 "VCore 2"
#    label in2 "+3.3V"
#    label in3 "+5V"
#    label in4 "+12V"
#    label in5 "-12V"
#    label in6 "-5V"

 ignore in0
 ignore in1
 ignore in4
 ignore in5
 ignore in6
 ignore temp1
  
#
# Here are the official LM78 and LM79 data sheet values.
#       Vs     R1,Rin   R2,Rf    Vin
# in3   +5.0      6.8    10     +2.98
# in4  +12.0     30      10     +3.00
# in5  -12.0    240      60     +3.00
# in6   -5.0    100      60     +3.00
#
# These would lead to these declarations:
 compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
# compute in4 ((30/10)+1)*@  ,  @/((30/10)+1)
# compute in5 -(240/60)*@    ,  -@/(240/60)
# compute in6 -(100/60)*@    ,  -@/(100/60)
#
# On almost any mainboard we have seen, the Winbond compute values lead to
# much better results, though.
#
#       Vs     R1,Rin   R2,Rf    Vin
# in4  +12.0     28      10     +3.15
# in5  -12.0    210      60.4   +3.45
# in6   -5.0     90.9    60.4   +3.33
#
# These leads to these declarations:

#    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
#    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
#    compute in5 -(210/60.4)*@  ,  -@/(210/60.4)
#    compute in6 -(90.9/60.4)*@ ,  -@/(90.9/60.4)

# Here, we assume the VID readings are valid, and we use a max. 5% deviation

    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05

# Ignore fans you don't actually have
#    ignore fan1
#    ignore fan2
#    ignore fan3

# In case a lm78 is used together with a lm75, the lm78 temp sensor will
# generally show the M/B temperature while the lm75 temp sensor will show
# the CPU temperature.
#    label temp1 "M/B Temp"

# Uncomment the following line to enable beeps for all alarms on this chip
#    set beep_enable 1



--------------020608080606090902040100
Content-Type: text/plain;
 name="sensors-det.txt"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="sensors-det.txt"

IyBzZW5zb3JzLWRldGVjdCByZXZpc2lvbiA1MjQ5ICgyMDA4LTA1LTExIDIyOjU2OjI1ICsw
MjAwKQoKVGhpcyBwcm9ncmFtIHdpbGwgaGVscCB5b3UgZGV0ZXJtaW5lIHdoaWNoIGtlcm5l
bCBtb2R1bGVzIHlvdSBuZWVkCnRvIGxvYWQgdG8gdXNlIGxtX3NlbnNvcnMgbW9zdCBlZmZl
Y3RpdmVseS4gSXQgaXMgZ2VuZXJhbGx5IHNhZmUKYW5kIHJlY29tbWVuZGVkIHRvIGFjY2Vw
dCB0aGUgZGVmYXVsdCBhbnN3ZXJzIHRvIGFsbCBxdWVzdGlvbnMsCnVubGVzcyB5b3Uga25v
dyB3aGF0IHlvdSdyZSBkb2luZy4KCldlIGNhbiBzdGFydCB3aXRoIHByb2JpbmcgZm9yIChQ
Q0kpIEkyQyBvciBTTUJ1cyBhZGFwdGVycy4KRG8geW91IHdhbnQgdG8gcHJvYmUgbm93PyAo
WUVTL25vKTogUHJvYmluZyBmb3IgUENJIGJ1cyBhZGFwdGVycy4uLgpVc2UgZHJpdmVyIGBp
MmMtaTgwMScgZm9yIGRldmljZSAwMDAwOjAwOjFmLjM6IEludGVsIElDSDEwCgpXZSB3aWxs
IG5vdyB0cnkgdG8gbG9hZCBlYWNoIGFkYXB0ZXIgbW9kdWxlIGluIHR1cm4uCkxvYWQgYGky
Yy1pODAxJyAoc2F5IE5PIGlmIGJ1aWx0IGludG8geW91ciBrZXJuZWwpPyAoWUVTL25vKTog
TW9kdWxlIGxvYWRlZCBzdWNjZXNzZnVsbHkuCklmIHlvdSBoYXZlIHVuZGV0ZWN0YWJsZSBv
ciB1bnN1cHBvcnRlZCBJMkMvU01CdXMgYWRhcHRlcnMsIHlvdSBjYW4gaGF2ZQp0aGVtIHNj
YW5uZWQgYnkgbWFudWFsbHkgbG9hZGluZyB0aGUgbW9kdWxlcyBiZWZvcmUgcnVubmluZyB0
aGlzIHNjcmlwdC4KCldlIGFyZSBub3cgZ29pbmcgdG8gZG8gdGhlIEkyQy9TTUJ1cyBhZGFw
dGVyIHByb2JpbmdzLiBTb21lIGNoaXBzIG1heQpiZSBkb3VibGUgZGV0ZWN0ZWQ7IHdlIGNo
b29zZSB0aGUgb25lIHdpdGggdGhlIGhpZ2hlc3QgY29uZmlkZW5jZQp2YWx1ZSBpbiB0aGF0
IGNhc2UuCklmIHlvdSBmb3VuZCB0aGF0IHRoZSBhZGFwdGVyIGh1bmcgYWZ0ZXIgcHJvYmlu
ZyBhIGNlcnRhaW4gYWRkcmVzcywKeW91IGNhbiBzcGVjaWZ5IHRoYXQgYWRkcmVzcyB0byBy
ZW1haW4gdW5wcm9iZWQuCgpOZXh0IGFkYXB0ZXI6IFNNQnVzIEk4MDEgYWRhcHRlciBhdCAw
NDAwIChpMmMtMCkKRG8geW91IHdhbnQgdG8gc2NhbiBpdD8gKFlFUy9uby9zZWxlY3RpdmVs
eSk6IENsaWVudCBmb3VuZCBhdCBhZGRyZXNzIDB4MTgKUHJvYmluZyBmb3IgYEFuYWxvZyBE
ZXZpY2VzIEFETTEwMjEnLi4uICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3Ig
YEFuYWxvZyBEZXZpY2VzIEFETTEwMjFBL0FETTEwMjMnLi4uICAgICAgICAgICAgTm8KUHJv
YmluZyBmb3IgYE1heGltIE1BWDE2MTcnLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgTm8KUHJvYmluZyBmb3IgYE1heGltIE1BWDE2MTdBJy4uLiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYE1heGltIE1BWDE2NjgnLi4uICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYE1heGltIE1BWDE4MDUnLi4u
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYE1heGltIE1B
WDE5ODknLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3Ig
YE1heGltIE1BWDY2NTUvTUFYNjY1NicuLi4gICAgICAgICAgICAgICAgICAgICAgTm8KUHJv
YmluZyBmb3IgYFRJIFRITUMxMCcuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgTm8KUHJvYmluZyBmb3IgYE5hdGlvbmFsIFNlbWljb25kdWN0b3IgTE04NCcuLi4gICAg
ICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYEdlbmVzeXMgTG9naWMgR0w1MjNTTScuLi4g
ICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYE9uc2VtaSBNQzEwNjYnLi4u
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYE1heGltIE1B
WDE2MTknLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3Ig
YE5hdGlvbmFsIFNlbWljb25kdWN0b3IgTE04Mi9MTTgzJy4uLiAgICAgICAgICAgTm8KUHJv
YmluZyBmb3IgYE1heGltIE1BWDY2ODAvTUFYNjY4MScuLi4gICAgICAgICAgICAgICAgICAg
ICAgTm8KUHJvYmluZyBmb3IgYE5hdGlvbmFsIFNlbWljb25kdWN0b3IgTE02NCcuLi4gICAg
ICAgICAgICAgICAgTm8KQ2xpZW50IGZvdW5kIGF0IGFkZHJlc3MgMHgyZApQcm9iaW5nIGZv
ciBgTXlzb24gTVRQMDA4Jy4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBObwpQ
cm9iaW5nIGZvciBgTmF0aW9uYWwgU2VtaWNvbmR1Y3RvciBMTTc4Jy4uLiAgICAgICAgICAg
ICAgICBTdWNjZXNzIQogICAgKGNvbmZpZGVuY2UgNiwgZHJpdmVyIGBsbTc4JykKUHJvYmlu
ZyBmb3IgYE5hdGlvbmFsIFNlbWljb25kdWN0b3IgTE03OC1KJy4uLiAgICAgICAgICAgICAg
Tm8KUHJvYmluZyBmb3IgYE5hdGlvbmFsIFNlbWljb25kdWN0b3IgTE03OScuLi4gICAgICAg
ICAgICAgICAgTm8KUHJvYmluZyBmb3IgYE5hdGlvbmFsIFNlbWljb25kdWN0b3IgTE04MCcu
Li4gICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYE5hdGlvbmFsIFNlbWljb25kdWN0
b3IgTE04NSBvciBMTTk2MDAwJy4uLiAgICAgTm8KUHJvYmluZyBmb3IgYEFuYWxvZyBEZXZp
Y2VzIEFETTEwMjcsIEFEVDc0NjAgb3IgQURUNzQ2MycuLi4gTm8KUHJvYmluZyBmb3IgYFNN
U0MgRU1DNkQxMDAsIEVNQzZEMTAxIG9yIEVNQzZEMTAyJy4uLiAgICAgICAgTm8KUHJvYmlu
ZyBmb3IgYEFuYWxvZyBEZXZpY2VzIEFEVDc0NzYnLi4uICAgICAgICAgICAgICAgICAgICAg
Tm8KUHJvYmluZyBmb3IgYEFuZGlnaWxvZyBhU0M3NjExJy4uLiAgICAgICAgICAgICAgICAg
ICAgICAgICAgTm8KUHJvYmluZyBmb3IgYEFuZGlnaWxvZyBhU0M3NjIxJy4uLiAgICAgICAg
ICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYE5hdGlvbmFsIFNlbWljb25kdWN0
b3IgTE04NycuLi4gICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYE5hdGlvbmFsIFNl
bWljb25kdWN0b3IgTE05MycuLi4gICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYFdp
bmJvbmQgVzgzNzgxRCcuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmlu
ZyBmb3IgYFdpbmJvbmQgVzgzNzgyRCcuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
Tm8KUHJvYmluZyBmb3IgYFdpbmJvbmQgVzgzNzgzUycuLi4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgTm8KUHJvYmluZyBmb3IgYFdpbmJvbmQgVzgzNzkyRCcuLi4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYFdpbmJvbmQgVzgzNzkzUi9HJy4u
LiAgICAgICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYFdpbmJvbmQgVzgz
NzkxU0QnLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYFdp
bmJvbmQgVzgzNjI3SEYnLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmlu
ZyBmb3IgYFdpbmJvbmQgVzgzNjI3RUhGJy4uLiAgICAgICAgICAgICAgICAgICAgICAgICAg
Tm8KUHJvYmluZyBmb3IgYFdpbmJvbmQgVzgzNjI3REhHJy4uLiAgICAgICAgICAgICAgICAg
ICAgICAgICAgTm8KUHJvYmluZyBmb3IgYEFzdXMgQVM5OTEyN0YgKHJldi4xKScuLi4gICAg
ICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYEFzdXMgQVM5OTEyN0YgKHJldi4y
KScuLi4gICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYEFzdXMgQVNCMTAw
IEJhY2gnLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYFdp
bmJvbmQgVzgzTDc4NFIvQVIvRycuLi4gICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmlu
ZyBmb3IgYFdpbmJvbmQgVzgzTDc4NVIvRycuLi4gICAgICAgICAgICAgICAgICAgICAgICAg
Tm8KUHJvYmluZyBmb3IgYEdlbmVzeXMgTG9naWMgR0w1MThTTSBSZXZpc2lvbiAweDAwJy4u
LiAgICAgICAgTm8KUHJvYmluZyBmb3IgYEdlbmVzeXMgTG9naWMgR0w1MThTTSBSZXZpc2lv
biAweDgwJy4uLiAgICAgICAgTm8KUHJvYmluZyBmb3IgYEdlbmVzeXMgTG9naWMgR0w1MjBT
TScuLi4gICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYEdlbmVzeXMgTG9n
aWMgR0w1MjVTTScuLi4gICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYEFu
YWxvZyBEZXZpY2VzIEFETTkyNDAnLi4uICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmlu
ZyBmb3IgYERhbGxhcyBTZW1pY29uZHVjdG9yIERTMTc4MCcuLi4gICAgICAgICAgICAgICAg
Tm8KUHJvYmluZyBmb3IgYE5hdGlvbmFsIFNlbWljb25kdWN0b3IgTE04MScuLi4gICAgICAg
ICAgICAgICAgTm8KUHJvYmluZyBmb3IgYEFuYWxvZyBEZXZpY2VzIEFETTEwMjYnLi4uICAg
ICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYEFuYWxvZyBEZXZpY2VzIEFETTEw
MjUnLi4uICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYFBoaWxpcHMgTkUx
NjE5Jy4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYEFu
YWxvZyBEZXZpY2VzIEFETTEwMjknLi4uICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmlu
ZyBmb3IgYEFuYWxvZyBEZXZpY2VzIEFETTEwMzAnLi4uICAgICAgICAgICAgICAgICAgICAg
Tm8KUHJvYmluZyBmb3IgYEFuYWxvZyBEZXZpY2VzIEFETTEwMzEnLi4uICAgICAgICAgICAg
ICAgICAgICAgTm8KUHJvYmluZyBmb3IgYEFuYWxvZyBEZXZpY2VzIEFETTEwMjInLi4uICAg
ICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYFRleGFzIEluc3RydW1lbnRzIFRI
TUM1MCcuLi4gICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYFZJQSBWVDEyMTEg
KEkyQyknLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYElU
RSBJVDg3MTJGJy4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmlu
ZyBmb3IgYEFMaSBNNTg3OScuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Tm8KUHJvYmluZyBmb3IgYFNNU0MgTFBDNDdNMTV4LzE5Mi8yOTIvOTk3Jy4uLiAgICAgICAg
ICAgICAgICAgTm8KUHJvYmluZyBmb3IgYFNNU0MgRE1FMTczNycuLi4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYFNNU0MgU0NINTAyN0QtTlcnLi4u
ICAgICAgICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYEZpbnRlayBGNzUz
NzNTL1NHJy4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYEZp
bnRlayBGNzUzNzVTL1NQJy4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgTm8KUHJvYmlu
ZyBmb3IgYEZpbnRlayBGNzUzODdTRy9SRycuLi4gICAgICAgICAgICAgICAgICAgICAgICAg
Tm8KUHJvYmluZyBmb3IgYEFuYWxvZyBEZXZpY2VzIEFETTEwMjQnLi4uICAgICAgICAgICAg
ICAgICAgICAgTm8KUHJvYmluZyBmb3IgYFdpbmJvbmQgVzgzNzkxRCcuLi4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgTm8KQ2xpZW50IGZvdW5kIGF0IGFkZHJlc3MgMHgyZQpQcm9i
aW5nIGZvciBgTXlzb24gTVRQMDA4Jy4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBObwpQcm9iaW5nIGZvciBgTmF0aW9uYWwgU2VtaWNvbmR1Y3RvciBMTTc4Jy4uLiAgICAg
ICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgTmF0aW9uYWwgU2VtaWNvbmR1Y3RvciBMTTc4
LUonLi4uICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgTmF0aW9uYWwgU2VtaWNvbmR1
Y3RvciBMTTc5Jy4uLiAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgTmF0aW9uYWwg
U2VtaWNvbmR1Y3RvciBMTTgwJy4uLiAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBg
TmF0aW9uYWwgU2VtaWNvbmR1Y3RvciBMTTg1IG9yIExNOTYwMDAnLi4uICAgICBObwpQcm9i
aW5nIGZvciBgQW5hbG9nIERldmljZXMgQURNMTAyNywgQURUNzQ2MCBvciBBRFQ3NDYzJy4u
LiBObwpQcm9iaW5nIGZvciBgU01TQyBFTUM2RDEwMCwgRU1DNkQxMDEgb3IgRU1DNkQxMDIn
Li4uICAgICAgICBObwpQcm9iaW5nIGZvciBgQW5hbG9nIERldmljZXMgQURUNzQ2MicuLi4g
ICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgQW5hbG9nIERldmljZXMgQURU
NzQ2NyBvciBBRFQ3NDY4Jy4uLiAgICAgICAgICBObwpQcm9iaW5nIGZvciBgQW5hbG9nIERl
dmljZXMgQURUNzQ3MCcuLi4gICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBg
QW5hbG9nIERldmljZXMgQURUNzQ3MycuLi4gICAgICAgICAgICAgICAgICAgICBObwpQcm9i
aW5nIGZvciBgQW5hbG9nIERldmljZXMgQURUNzQ3NScuLi4gICAgICAgICAgICAgICAgICAg
ICBObwpQcm9iaW5nIGZvciBgQW5hbG9nIERldmljZXMgQURUNzQ3NicuLi4gICAgICAgICAg
ICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgQW5kaWdpbG9nIGFTQzc2MTEnLi4uICAgICAg
ICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgQW5kaWdpbG9nIGFTQzc2MjEn
Li4uICAgICAgICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgTmF0aW9uYWwg
U2VtaWNvbmR1Y3RvciBMTTg3Jy4uLiAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBg
TmF0aW9uYWwgU2VtaWNvbmR1Y3RvciBMTTkzJy4uLiAgICAgICAgICAgICAgICBObwpQcm9i
aW5nIGZvciBgV2luYm9uZCBXODM3ODFEJy4uLiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBObwpQcm9iaW5nIGZvciBgV2luYm9uZCBXODM3ODJEJy4uLiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgV2luYm9uZCBXODM3OTJEJy4uLiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgV2luYm9uZCBXODM3OTNSL0cn
Li4uICAgICAgICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgV2luYm9uZCBX
ODM3OTFTRCcuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBg
V2luYm9uZCBXODM2MjdIRicuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICBObwpQcm9i
aW5nIGZvciBgV2luYm9uZCBXODM2MjdFSEYnLi4uICAgICAgICAgICAgICAgICAgICAgICAg
ICBObwpQcm9iaW5nIGZvciBgV2luYm9uZCBXODM2MjdESEcnLi4uICAgICAgICAgICAgICAg
ICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgQXN1cyBBUzk5MTI3RiAocmV2LjEpJy4uLiAg
ICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgQXN1cyBBUzk5MTI3RiAocmV2
LjIpJy4uLiAgICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgQXN1cyBBU0Ix
MDAgQmFjaCcuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBg
V2luYm9uZCBXODNMNzg2TlIvTkcvUi9HJy4uLiAgICAgICAgICAgICAgICAgICBObwpQcm9i
aW5nIGZvciBgV2luYm9uZCBXODNMNzg1VFMtUycuLi4gICAgICAgICAgICAgICAgICAgICAg
ICBObwpQcm9iaW5nIGZvciBgQW5hbG9nIERldmljZXMgQURNOTI0MCcuLi4gICAgICAgICAg
ICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgRGFsbGFzIFNlbWljb25kdWN0b3IgRFMxNzgw
Jy4uLiAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgTmF0aW9uYWwgU2VtaWNvbmR1
Y3RvciBMTTgxJy4uLiAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgQW5hbG9nIERl
dmljZXMgQURNMTAyNicuLi4gICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBg
QW5hbG9nIERldmljZXMgQURNMTAyNScuLi4gICAgICAgICAgICAgICAgICAgICBObwpQcm9i
aW5nIGZvciBgQW5hbG9nIERldmljZXMgQURNMTAyOScuLi4gICAgICAgICAgICAgICAgICAg
ICBObwpQcm9iaW5nIGZvciBgQW5hbG9nIERldmljZXMgQURNMTAzMCcuLi4gICAgICAgICAg
ICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgQW5hbG9nIERldmljZXMgQURNMTAzMScuLi4g
ICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgQW5hbG9nIERldmljZXMgQURN
MTAyMicuLi4gICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgVGV4YXMgSW5z
dHJ1bWVudHMgVEhNQzUwJy4uLiAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBg
QW5hbG9nIERldmljZXMgQURNMTAyOCcuLi4gICAgICAgICAgICAgICAgICAgICBObwpQcm9i
aW5nIGZvciBgSVRFIElUODcxMkYnLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBObwpQcm9iaW5nIGZvciBgU01TQyBETUUxNzM3Jy4uLiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgU01TQyBTQ0g1MDI3RC1OVycuLi4gICAgICAg
ICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgRmludGVrIEY3NTM3M1MvU0cn
Li4uICAgICAgICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgRmludGVrIEY3
NTM3NVMvU1AnLi4uICAgICAgICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBg
RmludGVrIEY3NTM4N1NHL1JHJy4uLiAgICAgICAgICAgICAgICAgICAgICAgICBObwpQcm9i
aW5nIGZvciBgQW5hbG9nIERldmljZXMgQURNMTAyNCcuLi4gICAgICAgICAgICAgICAgICAg
ICBObwpQcm9iaW5nIGZvciBgV2luYm9uZCBXODM3OTFEJy4uLiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBObwpDbGllbnQgZm91bmQgYXQgYWRkcmVzcyAweDJmClByb2JpbmcgZm9y
IGBOYXRpb25hbCBTZW1pY29uZHVjdG9yIExNNzgnLi4uICAgICAgICAgICAgICAgIE5vClBy
b2JpbmcgZm9yIGBOYXRpb25hbCBTZW1pY29uZHVjdG9yIExNNzgtSicuLi4gICAgICAgICAg
ICAgIE5vClByb2JpbmcgZm9yIGBOYXRpb25hbCBTZW1pY29uZHVjdG9yIExNNzknLi4uICAg
ICAgICAgICAgICAgIE5vClByb2JpbmcgZm9yIGBOYXRpb25hbCBTZW1pY29uZHVjdG9yIExN
ODAnLi4uICAgICAgICAgICAgICAgIE5vClByb2JpbmcgZm9yIGBBbmFsb2cgRGV2aWNlcyBB
RFQ3NDcwJy4uLiAgICAgICAgICAgICAgICAgICAgIE5vClByb2JpbmcgZm9yIGBXaW5ib25k
IFc4Mzc4MUQnLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5vClByb2JpbmcgZm9y
IGBXaW5ib25kIFc4Mzc4MkQnLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5vClBy
b2JpbmcgZm9yIGBXaW5ib25kIFc4Mzc5MkQnLi4uICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIE5vClByb2JpbmcgZm9yIGBXaW5ib25kIFc4Mzc5M1IvRycuLi4gICAgICAgICAgICAg
ICAgICAgICAgICAgIFN1Y2Nlc3MhCiAgICAoY29uZmlkZW5jZSA4LCBkcml2ZXIgYHc4Mzc5
MycsIG90aGVyIGFkZHJlc3NlczogMHg0YiAweDRmKQpQcm9iaW5nIGZvciBgV2luYm9uZCBX
ODM3OTFTRCcuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBg
V2luYm9uZCBXODM2MjdIRicuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICBObwpQcm9i
aW5nIGZvciBgV2luYm9uZCBXODM2MjdFSEYnLi4uICAgICAgICAgICAgICAgICAgICAgICAg
ICBObwpQcm9iaW5nIGZvciBgV2luYm9uZCBXODM2MjdESEcnLi4uICAgICAgICAgICAgICAg
ICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgQXN1cyBBUzk5MTI3RiAocmV2LjEpJy4uLiAg
ICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgQXN1cyBBUzk5MTI3RiAocmV2
LjIpJy4uLiAgICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgQXN1cyBBU0Ix
MDAgQmFjaCcuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBg
V2luYm9uZCBXODNMNzg2TlIvTkcvUi9HJy4uLiAgICAgICAgICAgICAgICAgICBObwpQcm9i
aW5nIGZvciBgQW5hbG9nIERldmljZXMgQURNOTI0MCcuLi4gICAgICAgICAgICAgICAgICAg
ICBObwpQcm9iaW5nIGZvciBgRGFsbGFzIFNlbWljb25kdWN0b3IgRFMxNzgwJy4uLiAgICAg
ICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgTmF0aW9uYWwgU2VtaWNvbmR1Y3RvciBMTTgx
Jy4uLiAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgQW5hbG9nIERldmljZXMgQURN
MTAyOScuLi4gICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBgSVRFIElUODcx
MkYnLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5nIGZvciBg
RmludGVrIGN1c3RvbSBwb3dlciBjb250cm9sIElDJy4uLiAgICAgICAgICAgICBObwpQcm9i
aW5nIGZvciBgV2luYm9uZCBXODM3OTFEJy4uLiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBObwpDbGllbnQgZm91bmQgYXQgYWRkcmVzcyAweDRiClByb2JpbmcgZm9yIGBOYXRpb25h
bCBTZW1pY29uZHVjdG9yIExNNzUnLi4uICAgICAgICAgICAgICAgIE5vClByb2JpbmcgZm9y
IGBEYWxsYXMgU2VtaWNvbmR1Y3RvciBEUzc1Jy4uLiAgICAgICAgICAgICAgICAgIE5vClBy
b2JpbmcgZm9yIGBOYXRpb25hbCBTZW1pY29uZHVjdG9yIExNNzcnLi4uICAgICAgICAgICAg
ICAgIE5vClByb2JpbmcgZm9yIGBEYWxsYXMgU2VtaWNvbmR1Y3RvciBEUzE2MjEvRFMxNjMx
Jy4uLiAgICAgICAgIE5vClByb2JpbmcgZm9yIGBNYXhpbSBNQVg2NjUwL01BWDY2NTEnLi4u
ICAgICAgICAgICAgICAgICAgICAgIE5vClByb2JpbmcgZm9yIGBOYXRpb25hbCBTZW1pY29u
ZHVjdG9yIExNOTInLi4uICAgICAgICAgICAgICAgIE5vClByb2JpbmcgZm9yIGBOYXRpb25h
bCBTZW1pY29uZHVjdG9yIExNNzYnLi4uICAgICAgICAgICAgICAgIE5vClByb2JpbmcgZm9y
IGBNYXhpbSBNQVg2NjMzL01BWDY2MzQvTUFYNjYzNScuLi4gICAgICAgICAgICAgIE5vCkNs
aWVudCBmb3VuZCBhdCBhZGRyZXNzIDB4NGYKUHJvYmluZyBmb3IgYE5hdGlvbmFsIFNlbWlj
b25kdWN0b3IgTE03NScuLi4gICAgICAgICAgICAgICAgTm8KUHJvYmluZyBmb3IgYERhbGxh
cyBTZW1pY29uZHVjdG9yIERTNzUnLi4uICAgICAgICAgICAgICAgICAgTm8KUHJvYmluZyBm
b3IgYERhbGxhcyBTZW1pY29uZHVjdG9yIERTMTYyMS9EUzE2MzEnLi4uICAgICAgICAgTm8K
UHJvYmluZyBmb3IgYE1heGltIE1BWDY2MzMvTUFYNjYzNC9NQVg2NjM1Jy4uLiAgICAgICAg
ICAgICAgTm8KQ2xpZW50IGZvdW5kIGF0IGFkZHJlc3MgMHg1MApQcm9iaW5nIGZvciBgQW5h
bG9nIERldmljZXMgQURNMTAzMycuLi4gICAgICAgICAgICAgICAgICAgICBObwpQcm9iaW5n
IGZvciBgQW5hbG9nIERldmljZXMgQURNMTAzNCcuLi4gICAgICAgICAgICAgICAgICAgICBO
bwpQcm9iaW5nIGZvciBgU1BEIEVFUFJPTScuLi4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBObwpQcm9iaW5nIGZvciBgRURJRCBFRVBST00nLi4uICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBObwoKU29tZSBjaGlwcyBhcmUgYWxzbyBhY2Nlc3NpYmxlIHRo
cm91Z2ggdGhlIElTQSBJL08gcG9ydHMuIFdlIGhhdmUgdG8Kd3JpdGUgdG8gYXJiaXRyYXJ5
IEkvTyBwb3J0cyB0byBwcm9iZSB0aGVtLiBUaGlzIGlzIHVzdWFsbHkgc2FmZSB0aG91Z2gu
ClllcywgeW91IGRvIGhhdmUgSVNBIEkvTyBwb3J0cyBldmVuIGlmIHlvdSBkbyBub3QgaGF2
ZSBhbnkgSVNBIHNsb3RzIQpEbyB5b3Ugd2FudCB0byBzY2FuIHRoZSBJU0EgSS9PIHBvcnRz
PyAoWUVTL25vKTogUHJvYmluZyBmb3IgYE5hdGlvbmFsIFNlbWljb25kdWN0b3IgTE03OCcg
YXQgMHgyOTAuLi4gICAgICAgTm8KUHJvYmluZyBmb3IgYE5hdGlvbmFsIFNlbWljb25kdWN0
b3IgTE03OC1KJyBhdCAweDI5MC4uLiAgICAgTm8KUHJvYmluZyBmb3IgYE5hdGlvbmFsIFNl
bWljb25kdWN0b3IgTE03OScgYXQgMHgyOTAuLi4gICAgICAgTm8KUHJvYmluZyBmb3IgYFdp
bmJvbmQgVzgzNzgxRCcgYXQgMHgyOTAuLi4gICAgICAgICAgICAgICAgICAgTm8KUHJvYmlu
ZyBmb3IgYFdpbmJvbmQgVzgzNzgyRCcgYXQgMHgyOTAuLi4gICAgICAgICAgICAgICAgICAg
Tm8KUHJvYmluZyBmb3IgYElQTUkgQk1DIEtDUycgYXQgMHhjYTAuLi4gICAgICAgICAgICAg
ICAgICAgICAgU3VjY2VzcyEKICAgIChjb25maWRlbmNlIDQsIGRyaXZlciBgaXBtaXNlbnNv
cnMnKQpQcm9iaW5nIGZvciBgSVBNSSBCTUMgU01JQycgYXQgMHhjYTguLi4gICAgICAgICAg
ICAgICAgICAgICBObwoKU29tZSBTdXBlciBJL08gY2hpcHMgbWF5IGFsc28gY29udGFpbiBz
ZW5zb3JzLiBXZSBoYXZlIHRvIHdyaXRlIHRvCnN0YW5kYXJkIEkvTyBwb3J0cyB0byBwcm9i
ZSB0aGVtLiBUaGlzIGlzIHVzdWFsbHkgc2FmZS4KRG8geW91IHdhbnQgdG8gc2NhbiBmb3Ig
U3VwZXIgSS9PIHNlbnNvcnM/IChZRVMvbm8pOiBQcm9iaW5nIGZvciBTdXBlci1JL08gYXQg
MHgyZS8weDJmClRyeWluZyBmYW1pbHkgYE5hdGlvbmFsIFNlbWljb25kdWN0b3InLi4uICAg
ICAgICAgICAgICAgICAgIE5vClRyeWluZyBmYW1pbHkgYFNNU0MnLi4uICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIE5vClRyeWluZyBmYW1pbHkgYFZJQS9XaW5ib25k
L0ZpbnRlaycuLi4gICAgICAgICAgICAgICAgICAgICAgIFllcwpGb3VuZCB1bmtub3duIGNo
aXAgd2l0aCBJRCAweGIwNzMKUHJvYmluZyBmb3IgU3VwZXItSS9PIGF0IDB4NGUvMHg0ZgpU
cnlpbmcgZmFtaWx5IGBOYXRpb25hbCBTZW1pY29uZHVjdG9yJy4uLiAgICAgICAgICAgICAg
ICAgICBObwpUcnlpbmcgZmFtaWx5IGBTTVNDJy4uLiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBObwpUcnlpbmcgZmFtaWx5IGBWSUEvV2luYm9uZC9GaW50ZWsnLi4u
ICAgICAgICAgICAgICAgICAgICAgICBObwpUcnlpbmcgZmFtaWx5IGBJVEUnLi4uICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBObwoKU29tZSBzb3V0aCBicmlkZ2Vz
LCBDUFVzIG9yIG1lbW9yeSBjb250cm9sbGVycyBtYXkgYWxzbyBjb250YWluCmVtYmVkZGVk
IHNlbnNvcnMuIERvIHlvdSB3YW50IHRvIHNjYW4gZm9yIHRoZW0/IChZRVMvbm8pOiBTaWxp
Y29uIEludGVncmF0ZWQgU3lzdGVtcyBTSVM1NTk1Li4uICAgICAgICAgICAgICAgICAgICAg
ICBObwpWSUEgVlQ4MkM2ODYgSW50ZWdyYXRlZCBTZW5zb3JzLi4uICAgICAgICAgICAgICAg
ICAgICAgICAgICBObwpWSUEgVlQ4MjMxIEludGVncmF0ZWQgU2Vuc29ycy4uLiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBObwpBTUQgSzggdGhlcm1hbCBzZW5zb3JzLi4uICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBObwpBTUQgSzEwIHRoZXJtYWwgc2Vuc29y
cy4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBObwpJbnRlbCBDb3JlIGZh
bWlseSB0aGVybWFsIHNlbnNvci4uLiAgICAgICAgICAgICAgICAgICAgICAgICBObwpJbnRl
bCBBTUIgRkItRElNTSB0aGVybWFsIHNlbnNvci4uLiAgICAgICAgICAgICAgICAgICAgICAg
ICBObwoKTm93IGZvbGxvd3MgYSBzdW1tYXJ5IG9mIHRoZSBwcm9iZXMgSSBoYXZlIGp1c3Qg
ZG9uZS4KSnVzdCBwcmVzcyBFTlRFUiB0byBjb250aW51ZTogCkRyaXZlciBgbG03OCcgKHNo
b3VsZCBiZSBpbnNlcnRlZCk6CiAgRGV0ZWN0cyBjb3JyZWN0bHk6CiAgKiBCdXMgYFNNQnVz
IEk4MDEgYWRhcHRlciBhdCAwNDAwJwogICAgQnVzZHJpdmVyIGBpMmMtaTgwMScsIEkyQyBh
ZGRyZXNzIDB4MmQKICAgIENoaXAgYE5hdGlvbmFsIFNlbWljb25kdWN0b3IgTE03OCcgKGNv
bmZpZGVuY2U6IDYpCgpEcml2ZXIgYHc4Mzc5MycgKHNob3VsZCBiZSBpbnNlcnRlZCk6CiAg
RGV0ZWN0cyBjb3JyZWN0bHk6CiAgKiBCdXMgYFNNQnVzIEk4MDEgYWRhcHRlciBhdCAwNDAw
JwogICAgQnVzZHJpdmVyIGBpMmMtaTgwMScsIEkyQyBhZGRyZXNzIDB4MmYgKGFuZCAweDRi
IDB4NGYpCiAgICBDaGlwIGBXaW5ib25kIFc4Mzc5M1IvRycgKGNvbmZpZGVuY2U6IDgpCgpE
cml2ZXIgYGlwbWlzZW5zb3JzJyAoc2hvdWxkIGJlIGluc2VydGVkKToKICBEZXRlY3RzIGNv
cnJlY3RseToKICAqIElTQSBidXMsIGFkZHJlc3MgMHhjYTAKICAgIENoaXAgYElQTUkgQk1D
IEtDUycgKGNvbmZpZGVuY2U6IDQpCgpJIHdpbGwgbm93IGdlbmVyYXRlIHRoZSBjb21tYW5k
cyBuZWVkZWQgdG8gbG9hZCB0aGUgcmVxdWlyZWQgbW9kdWxlcy4KSnVzdCBwcmVzcyBFTlRF
UiB0byBjb250aW51ZTogClRvIGxvYWQgZXZlcnl0aGluZyB0aGF0IGlzIG5lZWRlZCwgYWRk
IHRoaXMgdG8gL2V0Yy9tb2R1bGVzOgoKIy0tLS1jdXQgaGVyZS0tLS0KIyBJMkMgYWRhcHRl
ciBkcml2ZXJzCmkyYy1pODAxCiMgWW91IG11c3QgYWxzbyBpbnN0YWxsIGFuZCBsb2FkIHRo
ZSBJUE1JIG1vZHVsZXMKaXBtaS1zaQojIENoaXAgZHJpdmVycwpsbTc4Cnc4Mzc5MwojIFdh
cm5pbmc6IHRoZSByZXF1aXJlZCBtb2R1bGUgaXBtaXNlbnNvcnMgaXMgbm90IGN1cnJlbnRs
eSBpbnN0YWxsZWQKIyBvbiB5b3VyIHN5c3RlbS4gRm9yIHN0YXR1cyBvZiAyLjYga2VybmVs
IHBvcnRzIGNoZWNrCiMgaHR0cDovL3d3dy5sbS1zZW5zb3JzLm9yZy93aWtpL0RldmljZXMu
IElmIGRyaXZlciBpcyBidWlsdAojIGludG8gdGhlIGtlcm5lbCwgb3IgdW5hdmFpbGFibGUs
IGNvbW1lbnQgb3V0IHRoZSBmb2xsb3dpbmcgbGluZS4KaXBtaXNlbnNvcnMKIy0tLS1jdXQg
aGVyZS0tLS0KCkRvIHlvdSB3YW50IHRvIGFkZCB0aGVzZSBsaW5lcyBhdXRvbWF0aWNhbGx5
PyAoeWVzL05PKQ==
--------------020608080606090902040100
Content-Type: text/plain;
 name="sensors-out.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="sensors-out.txt"

lm78-i2c-0-2d
Adapter: SMBus I801 adapter at 0400
in2:         +3.38 V  (min =  +3.14 V, max =  +3.47 V)   ALARM
in3:         +5.67 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
fan1:          0 RPM  (min = 4963 RPM, div = 2)  ALARM
fan2:          0 RPM  (min = 4500 RPM, div = 2)  ALARM
fan3:          0 RPM  (min = 112500 RPM, div = 2)  ALARM
cpu0_vid:   +3.000 V

w83793-i2c-0-2f
Adapter: SMBus I801 adapter at 0400
in0:         +0.85 V  (min =  +0.00 V, max =  +2.05 V)   
in1:         +0.91 V  (min =  +0.00 V, max =  +2.05 V)   
in2:         +1.09 V  (min =  +0.00 V, max =  +2.05 V)   
in3:         +1.47 V  (min =  +0.00 V, max =  +4.08 V)   
in4:         +1.07 V  (min =  +0.00 V, max =  +4.08 V)   
in5:         +3.33 V  (min =  +0.00 V, max =  +4.08 V)   
in6:        +12.00 V  (min =  +0.00 V, max = +24.48 V)   
in7:         +5.14 V  (min =  +0.15 V, max =  +6.27 V)   
in8:         +5.12 V  (min =  +0.15 V, max =  +6.27 V)   
in9:         +3.09 V  (min =  +0.00 V, max =  +4.08 V)   
CPU0fan J36:3868 RPM  (min =  800 RPM)
CPU1fan J37:3824 RPM  (min =  800 RPM)
fan J40:       0 RPM  (min =  800 RPM)  ALARM
fan J41:    3846 RPM  (min =  800 RPM)
fan J42:    1956 RPM  (min =  800 RPM)
fan6:          0 RPM  (min =    0 RPM)
fan7:          0 RPM  (min =    0 RPM)
fan8:          0 RPM  (min =    0 RPM)
fan9:          0 RPM  (min =    0 RPM)  ALARM
fan10:         0 RPM  (min =    0 RPM)  ALARM
fan11:         0 RPM  (min =    0 RPM)  ALARM
fan12:         0 RPM  (min =    0 RPM)  ALARM
temp1:       +47.8������C  (high = +100.0������C, hyst = +95.0������C)  sensor = Intel PECI
temp2:       +49.8������C  (high = +100.0������C, hyst = +95.0������C)  sensor = Intel PECI
temp5:       -62.0������C  (high = +100.0������C, hyst = +95.0������C)  sensor = thermistor
temp6:       +33.0������C  (high = +100.0������C, hyst = +95.0������C)  sensor = thermistor
beep_enable:disabled


--------------020608080606090902040100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020608080606090902040100--
