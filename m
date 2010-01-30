From: Lou Gosselin <tech2009@evergrove.com>
Date: Sat, 30 Jan 2010 00:17:06 +0000
Subject: Re: [lm-sensors] "No sensors found!" on Intel Entry Storage System
Message-Id: <4B637A82.9040902@evergrove.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060900040809010607010700"
List-Id: <lm-sensors.vger.kernel.org>
References: <1251523453.13079.32.camel@Ubuntu>
In-Reply-To: <1251523453.13079.32.camel@Ubuntu>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------060900040809010607010700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jean Delvare wrote:
> On Wed, 2 Sep 2009 21:29:16 +0200, Jean Delvare wrote:
>   
>> On Wed, 2 Sep 2009 02:23:52 +0200, Hubert Kario wrote:
>>     
>>> On Tuesday 01 September 2009 23:27:28 Tech2009 wrote:
>>>       
>>>> Thank you for the suggestions.
>>>>
>>>> I looked in sysfs on the factory distro, no sign of dme1737 there (see
>>>> attached). However there are other i2c devices not on my debian
>>>> install...you could be right about the direct port io, but without
>>>> disassembling the library it's hard to tell.
>>>>
>>>> I tried loading dme1737 with force_start, but that made no difference
>>>> for me.
>>>>         
>>> I was thinking about using the 'force' parameter to givie the address 
>>> explicitly to the module, the device may be on non standard port.
>>> sensors-detect is usually more capable of detecting devices than kernel 
>>> modules
>>>       
>> Good point. The dme1737 driver only recognizes version/stepping value
>> of 0x69 as the SCH5027. sensors-detect OTOH recognizes all version/
>> steppings from 0x69 to 0x6f. It would be interesting to see a dump of
>> the chip (modprobe i2c-dev then run i2cdump), I'd guess you have a
>> version/stepping value > 0x69.
>>     
>
> Ping. Can we have the output of i2cdump for your chip, please?
>
>   
>> It might help to have a physical look at the chip and read the top
>> marking, if this is possible.
>>     
>
> This would also be helpful, if possible.
>
>   
Wow, it's been a while since then, I'm not on the list any longer.

I've attached two files.
sensors.txt shows the output that I get with sensors-detect and sensors.

i2cbus.txt shows output for i2cdetect and i2cdump.
Let me point out that after running "i2cdump 0 0x6a", lmsensors was no 
longer responsive. Furthermore the machine failed to reboot until I did 
a cold boot.


I'm not sure what chip to look for, but according to this document:
http://download.intel.com/support/motherboards/server/ss4200-e/sb/ss4200e_tps_11.pdf
"Enclosure management is performed by a SMSC SCH5027D part with an 
integrated hardware monitor controller. The SMSC component monitors 
various aspects of the storage enclosure."

If you feel it's helpful I can try to take a picture.

I'll give any suggestions a shot, or if you're willing, I can setup one 
of these machines for you to connect to.


--------------060900040809010607010700
Content-Type: text/plain;
 name="i2cbus.txt"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="i2cbus.txt"

U2NyaXB0IHN0YXJ0ZWQgb24gRnJpIDI5IEphbiAyMDEwIDA2OjQxOjE3IFBNIEVTVAppbnRl
bC1zczQyMDA6fiMgaTJjZGV0ZWN0IDANCldBUk5JTkchIFRoaXMgcHJvZ3JhbSBjYW4gY29u
ZnVzZSB5b3VyIEkyQyBidXMsIGNhdXNlIGRhdGEgbG9zcyBhbmQgd29yc2UhDQpJIHdpbGwg
cHJvYmUgZmlsZSAvZGV2L2kyYy0wLg0KSSB3aWxsIHByb2JlIGFkZHJlc3MgcmFuZ2UgMHgw
My0weDc3Lg0KQ29udGludWU/IFtZL25dIA0KICAgICAwICAxICAyICAzICA0ICA1ICA2ICA3
ICA4ICA5ICBhICBiICBjICBkICBlICBmDQowMDogICAgICAgICAgLS0gLS0gLS0gLS0gLS0g
MDggLS0gLS0gLS0gLS0gLS0gLS0gLS0gDQoxMDogLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0g
LS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gDQoyMDogLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0g
LS0gLS0gLS0gLS0gLS0gLS0gMmUgLS0gDQozMDogLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0g
LS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gDQo0MDogLS0gLS0gLS0gLS0gNDQgLS0gLS0gLS0g
LS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gDQo1MDogNTAgLS0gLS0gLS0gLS0gLS0gLS0gLS0g
LS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0gDQo2MDogLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0g
LS0gNjkgNmEgLS0gLS0gLS0gLS0gLS0gDQo3MDogLS0gLS0gLS0gLS0gLS0gLS0gLS0gLS0g
ICAgICAgICAgICAgICAgICAgICAgICAgDQppbnRlbC1zczQyMDA6fiMgaTJjZHVtcCAwIDB4
NjkNCk5vIHNpemUgc3BlY2lmaWVkICh1c2luZyBieXRlLWRhdGEgYWNjZXNzKQ0KV0FSTklO
RyEgVGhpcyBwcm9ncmFtIGNhbiBjb25mdXNlIHlvdXIgSTJDIGJ1cywgY2F1c2UgZGF0YSBs
b3NzIGFuZCB3b3JzZSENCkkgd2lsbCBwcm9iZSBmaWxlIC9kZXYvaTJjLTAsIGFkZHJlc3Mg
MHg2OSwgbW9kZSBieXRlDQpDb250aW51ZT8gW1kvbl0gDQogICAgIDAgIDEgIDIgIDMgIDQg
IDUgIDYgIDcgIDggIDkgIGEgIGIgIGMgIGQgIGUgIGYgICAgMDEyMzQ1Njc4OWFiY2RlZg0K
MDA6IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4ICAg
ID8/Pz8/Pz8/Pz8/Pz8/Pz8NCjEwOiAwOCAwOCAwOCAwOCAwOCAwOCAwOCAwOCAwOCAwOCAw
OCAwOCAwOCAwOCAwOCAwOCAgICA/Pz8/Pz8/Pz8/Pz8/Pz8/DQoyMDogMDggMDggMDggMDgg
MDggMDggMDggMDggMDggMDggMDggMDggMDggMDggMDggMDggICAgPz8/Pz8/Pz8/Pz8/Pz8/
Pw0KMzA6IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4
ICAgID8/Pz8/Pz8/Pz8/Pz8/Pz8NCjQwOiAwOCAwOCAwOCAwOCAwOCAwOCAwOCAwOCAwOCAw
OCAwOCAwOCAwOCAwOCAwOCAwOCAgICA/Pz8/Pz8/Pz8/Pz8/Pz8/DQo1MDogMDggMDggMDgg
MDggMDggMDggMDggMDggMDggMDggMDggMDggMDggMDggMDggMDggICAgPz8/Pz8/Pz8/Pz8/
Pz8/Pw0KNjA6IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4IDA4
IDA4ICAgID8/Pz8/Pz8/Pz8/Pz8/Pz8NCjcwOiAwOCAwOCAwOCAwOCAwOCAwOCAwOCAwOCAw
OCAwOCAwOCAwOCAwOCAwOCAwOCAwOCAgICA/Pz8/Pz8/Pz8/Pz8/Pz8/DQo4MDogZmYgZjYg
MDMgMDAgMDcgMDAgMWEgMDUgODAgMTEgMDAgMDMgZmYgZmYgZmYgZmYgICAgLj8/Lj8uPz8/
Py4/Li4uLg0KOTA6IGZmIDk2IDAxIGZmIGZmIGZmIGZmIGZmIGZmIDk2IDAxIDAwIGZmIDE1
IDAwIDAwICAgIC4/Py4uLi4uLj8/Li4/Li4NCmEwOiAwOCBiNCAxYiBiNCBmZiBmZiBmZiBm
ZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiAgICA/Pz8/Li4uLi4uLi4uLi4uDQpiMDogZmYg
ZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgMDEgMTEgICAgLi4uLi4u
Li4uLi4uLi4/Pw0KYzA6IGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZm
IGZmIGZmIGZmICAgIC4uLi4uLi4uLi4uLi4uLi4NCmQwOiBmZiBmZiBmZiBmZiBmZiBmZiBm
ZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiAgICAuLi4uLi4uLi4uLi4uLi4uDQplMDog
ZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgICAgLi4u
Li4uLi4uLi4uLi4uLg0KZjA6IGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZm
IGZmIGZmIGZmIGZmICAgIC4uLi4uLi4uLi4uLi4uLi4NCmludGVsLXNzNDIwMDp+IyBpMmNk
dW1wIDAgMHg2OQgbW0thDQpObyBzaXplIHNwZWNpZmllZCAodXNpbmcgYnl0ZS1kYXRhIGFj
Y2VzcykNCldBUk5JTkchIFRoaXMgcHJvZ3JhbSBjYW4gY29uZnVzZSB5b3VyIEkyQyBidXMs
IGNhdXNlIGRhdGEgbG9zcyBhbmQgd29yc2UhDQpJIHdpbGwgcHJvYmUgZmlsZSAvZGV2L2ky
Yy0wLCBhZGRyZXNzIDB4NmEsIG1vZGUgYnl0ZQ0KQ29udGludWU/IFtZL25dIA0KICAgICAw
ICAxICAyICAzICA0ICA1ICA2ICA3ICA4ICA5ICBhICBiICBjICBkICBlICBmICAgIDAxMjM0
NTY3ODlhYmNkZWYNCjAwOiAwNiAwNiAwNiAwNiAwNiAwNiAwNiAwNiAwNiAwNiAwNiAwNiAw
NiAwNiAwNiAwNiAgICA/Pz8/Pz8/Pz8/Pz8/Pz8/DQoxMDogMDYgMDYgMDYgMDYgMDYgMDYg
MDYgMDYgMDYgMDYgMDYgMDYgMDYgMDYgMDYgMDYgICAgPz8/Pz8/Pz8/Pz8/Pz8/Pw0KMjA6
IDA2IDA2IDA2IDA2IDA2IDA2IDA2IDA2IDA2IDA2IDA2IDA2IDA2IDA2IDA2IDA2ICAgID8/
Pz8/Pz8/Pz8/Pz8/Pz8NCjMwOiAwNiAwNiAwNiAwNiAwNiAwNiAwNiAwNiAwNiAwNiAwNiAw
NiAwNiAwNiAwNiAwNiAgICA/Pz8/Pz8/Pz8/Pz8/Pz8/DQo0MDogMDYgMDYgMDYgMDYgMDYg
MDYgMDYgMDYgMDYgMDYgMDYgMDYgMDYgMDYgMDYgMDYgICAgPz8/Pz8/Pz8/Pz8/Pz8/Pw0K
NTA6IDA2IDA2IDA2IDA2IDA2IDA2IDA2IDA2IDA2IDA2IDA2IDA2IDA2IDA2IDA2IDA2ICAg
ID8/Pz8/Pz8/Pz8/Pz8/Pz8NCjYwOiAwNiAwNiAwNiAwNiAwNiAwNiAwNiAwNiAwNiAwNiAw
NiAwNiAwNiAwNiAwNiAwNiAgICA/Pz8/Pz8/Pz8/Pz8/Pz8/DQo3MDogMDYgMDYgMDYgMDYg
MDYgMDYgMDYgMDYgMDYgMDYgMDYgMDYgMDYgMDYgMDYgMDYgICAgPz8/Pz8/Pz8/Pz8/Pz8/
Pw0KODA6IDhmIGZmIDAwIDExIDA2IDA2IDAwIDAwIDAwIDAwIDgwIDAwIDAwIDAwIDAwIGQ1
ICAgID8uLj8/Py4uLi4/Li4uLj8NCjkwOiBkNSBkNSBkNSBkNSBkNSBkNSBkNSBkNSBkNSBk
NSBkNSBkNSBkNSBkNSBYWCBYWCAgICA/Pz8/Pz8/Pz8/Pz8/P1hYDQphMDogWFggWFggWFgg
WFggWFggWFggWFggWFggWFggWFggWFggWFggWFggWFggWFggWFggICAgWFhYWFhYWFhYWFhY
WFhYWA0KYjA6IFhYIFhYIFhYIFhYIFhYIFhYIFhYIFhYIFhYIFhYIFhYIFhYIFhYIFhYIFhY
IFhYICAgIFhYWFhYWFhYWFhYWFhYWFgNCmMwOiBYWCBYWCBYWCBYWCBYWCBYWCBYWCBYWCBY
WCBYWCBYWCBYWCBYWCBYWCBYWCBYWCAgICBYWFhYWFhYWFhYWFhYWFhYDQpkMDogWFggWFgg
WFggWFggWFggWFggWFggWFggWFggWFggWFggWFggWFggWFggWFggWFggICAgWFhYWFhYWFhY
WFhYWFhYWA0KZTA6IFhYIFhYIFhYIFhYIFhYIFhYIFhYIFhYIFhYIFhYIFhYIFhYIFhYIFhY
IFhYIFhYICAgIFhYWFhYWFhYWFhYWFhYWFgNCmYwOiBYWCBYWCBYWCBYWCBYWCBYWCBYWCBY
WCBYWCBYWCBYWCBYWCBYWCBYWCBYWCBYWCAgICBYWFhYWFhYWFhYWFhYWFhYDQppbnRlbC1z
czQyMDA6fiMgc2VuZG8IG1tLCBtbS3NvcnMtZGV0ZWN0DQojIHNlbnNvcnMtZGV0ZWN0IHJl
dmlzaW9uIDUyNDkgKDIwMDgtMDUtMTEgMjI6NTY6MjUgKzAyMDApDQoNClRoaXMgcHJvZ3Jh
bSB3aWxsIGhlbHAgeW91IGRldGVybWluZSB3aGljaCBrZXJuZWwgbW9kdWxlcyB5b3UgbmVl
ZA0KdG8gbG9hZCB0byB1c2UgbG1fc2Vuc29ycyBtb3N0IGVmZmVjdGl2ZWx5LiBJdCBpcyBn
ZW5lcmFsbHkgc2FmZQ0KYW5kIHJlY29tbWVuZGVkIHRvIGFjY2VwdCB0aGUgZGVmYXVsdCBh
bnN3ZXJzIHRvIGFsbCBxdWVzdGlvbnMsDQp1bmxlc3MgeW91IGtub3cgd2hhdCB5b3UncmUg
ZG9pbmcuDQoNCldlIGNhbiBzdGFydCB3aXRoIHByb2JpbmcgZm9yIChQQ0kpIEkyQyBvciBT
TUJ1cyBhZGFwdGVycy4NCkRvIHlvdSB3YW50IHRvIHByb2JlIG5vdz8gKFlFUy9ubyk6IA0K
UHJvYmluZyBmb3IgUENJIGJ1cyBhZGFwdGVycy4uLg0KVXNlIGRyaXZlciBgaTJjLWk4MDEn
IGZvciBkZXZpY2UgMDAwMDowMDoxZi4zOiBJbnRlbCA4MjgwMUcgSUNINw0KDQpXZSB3aWxs
IG5vdyB0cnkgdG8gbG9hZCBlYWNoIGFkYXB0ZXIgbW9kdWxlIGluIHR1cm4uDQpNb2R1bGUg
YGkyYy1pODAxJyBhbHJlYWR5IGxvYWRlZC4NCklmIHlvdSBoYXZlIHVuZGV0ZWN0YWJsZSBv
ciB1bnN1cHBvcnRlZCBJMkMvU01CdXMgYWRhcHRlcnMsIHlvdSBjYW4gaGF2ZQ0KdGhlbSBz
Y2FubmVkIGJ5IG1hbnVhbGx5IGxvYWRpbmcgdGhlIG1vZHVsZXMgYmVmb3JlIHJ1bm5pbmcg
dGhpcyBzY3JpcHQuDQoNCldlIGFyZSBub3cgZ29pbmcgdG8gZG8gdGhlIEkyQy9TTUJ1cyBh
ZGFwdGVyIHByb2JpbmdzLiBTb21lIGNoaXBzIG1heQ0KYmUgZG91YmxlIGRldGVjdGVkOyB3
ZSBjaG9vc2UgdGhlIG9uZSB3aXRoIHRoZSBoaWdoZXN0IGNvbmZpZGVuY2UNCnZhbHVlIGlu
IHRoYXQgY2FzZS4NCklmIHlvdSBmb3VuZCB0aGF0IHRoZSBhZGFwdGVyIGh1bmcgYWZ0ZXIg
cHJvYmluZyBhIGNlcnRhaW4gYWRkcmVzcywNCnlvdSBjYW4gc3BlY2lmeSB0aGF0IGFkZHJl
c3MgdG8gcmVtYWluIHVucHJvYmVkLg0KDQpOZXh0IGFkYXB0ZXI6IFNNQnVzIEk4MDEgYWRh
cHRlciBhdCAwNDAwIChpMmMtMCkNCkRvIHlvdSB3YW50IHRvIHNjYW4gaXQ/IChZRVMvbm8v
c2VsZWN0aXZlbHkpOiANCg0KXkMNCmludGVsLXNzNDIwMDp+IyANCmludGVsLXNzNDIwMDp+
IyBleGl0DQoKU2NyaXB0IGRvbmUgb24gRnJpIDI5IEphbiAyMDEwIDA2OjQzOjUxIFBNIEVT
VAo=
--------------060900040809010607010700
Content-Type: text/plain;
 name="sensors.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="sensors.txt"

Script started on Fri 29 Jan 2010 06:48:54 PM EST
intel-ss4200:~# sn[Kensors-detect
# sensors-detect revision 5249 (2008-05-11 22:56:25 +0200)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no): 
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported I2C/SMBus adapters, you can have
them scanned by manually loading the modules before running this script.

To continue, we need module `i2c-dev' to be loaded.
Do you want to load `i2c-dev' now? (YES/no): 
Module loaded successfully.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus I801 adapter at 0400 (i2c-0)
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x2e
Probing for `Myson MTP008'...                               No
Probing for `National Semiconductor LM78'...                No
Probing for `National Semiconductor LM78-J'...              No
Probing for `National Semiconductor LM79'...                No
Probing for `National Semiconductor LM80'...                No
Probing for `National Semiconductor LM85 or LM96000'...     No
Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... No
Probing for `SMSC EMC6D100, EMC6D101 or EMC6D102'...        No
Probing for `Analog Devices ADT7462'...                     No
Probing for `Analog Devices ADT7467 or ADT7468'...          No
Probing for `Analog Devices ADT7470'...                     No
Probing for `Analog Devices ADT7473'...                     No
Probing for `Analog Devices ADT7475'...                     No
Probing for `Analog Devices ADT7476'...                     No
Probing for `Andigilog aSC7611'...                          No
Probing for `Andigilog aSC7621'...                          No
Probing for `National Semiconductor LM87'...                No
Probing for `National Semiconductor LM93'...                No
Probing for `Winbond W83781D'...                            No
Probing for `Winbond W83782D'...                            No
Probing for `Winbond W83792D'...                            No
Probing for `Winbond W83793R/G'...                          No
Probing for `Winbond W83791SD'...                           No
Probing for `Winbond W83627HF'...                           No
Probing for `Winbond W83627EHF'...                          No
Probing for `Winbond W83627DHG'...                          No
Probing for `Asus AS99127F (rev.1)'...                      No
Probing for `Asus AS99127F (rev.2)'...                      No
Probing for `Asus ASB100 Bach'...                           No
Probing for `Winbond W83L786NR/NG/R/G'...                   No
Probing for `Winbond W83L785TS-S'...                        No
Probing for `Analog Devices ADM9240'...                     No
Probing for `Dallas Semiconductor DS1780'...                No
Probing for `National Semiconductor LM81'...                No
Probing for `Analog Devices ADM1026'...                     No
Probing for `Analog Devices ADM1025'...                     No
Probing for `Analog Devices ADM1029'...                     No
Probing for `Analog Devices ADM1030'...                     No
Probing for `Analog Devices ADM1031'...                     No
Probing for `Analog Devices ADM1022'...                     No
Probing for `Texas Instruments THMC50'...                   No
Probing for `Analog Devices ADM1028'...                     No
Probing for `ITE IT8712F'...                                No
Probing for `SMSC DME1737'...                               No
Probing for `SMSC SCH5027D-NW'...                           Success!
    (confidence 6, driver `dme1737')
Probing for `Fintek F75373S/SG'...                          No
Probing for `Fintek F75375S/SP'...                          No
Probing for `Fintek F75387SG/RG'...                         No
Probing for `Analog Devices ADM1024'...                     No
Probing for `Winbond W83791D'...                            No
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no): 
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): 
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found `SMSC SCH5027D-NW Super IO'                           
    (hardware monitoring capabilities accessible via SMBus only)

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no): 
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue: 

Driver `dme1737' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0400'
    Busdriver `i2c-i801', I2C address 0x2e
    Chip `SMSC SCH5027D-NW' (confidence: 6)

Driver `coretemp' (should be inserted):
  Detects correctly:
  * Chip `Intel Core family thermal sensor' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue: 

To load everything that is needed, add this to /etc/modules:

#----cut here----
# I2C adapter drivers
i2c-i801
# Chip drivers
dme1737
coretemp
#----cut here----

Do you want to add these lines automatically? (yes/NO)
intel-ss4200:~# modprobe coretemp
intel-ss4200:~# modprobe i2c-i801
intel-ss4200:~# modprobe dme1737
intel-ss4200:~# sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +27.0������C  (high = +86.0������C, crit = +100.0������C)  

intel-ss4200:~# lsmod
Module                  Size  Used by
i2c_dev                10640  0 
ipv6                  288456  16 
xt_tcpudp               7680  1 
iptable_nat             9872  1 
nf_nat                 23192  1 iptable_nat
nf_conntrack_ipv4      19352  3 iptable_nat,nf_nat
nf_conntrack           71440  3 iptable_nat,nf_nat,nf_conntrack_ipv4
ip_tables              21520  1 iptable_nat
x_tables               25224  3 xt_tcpudp,iptable_nat,ip_tables
coretemp               11008  0 
dme1737                43168  0 
hwmon_vid               7296  1 dme1737
loop                   19468  0 
snd_pcm                81800  0 
snd_timer              25744  1 snd_pcm
snd                    63688  2 snd_pcm,snd_timer
soundcore              12064  1 snd
snd_page_alloc         13072  1 snd_pcm
psmouse                42268  0 
pcspkr                  7040  0 
serio_raw               9988  0 
i2c_i801               13596  0 
i2c_core               27936  3 i2c_dev,dme1737,i2c_i801
rng_core                8968  0 
button                 11680  0 
intel_agp              31856  1 
evdev                  14208  0 
ext3                  125072  1 
jbd                    51240  1 ext3
mbcache                12804  1 ext3
sd_mod                 29376  3 
ahci                   33036  2 
ehci_hcd               36108  0 
uhci_hcd               25760  0 
sata_sil24             18180  0 
libata                165600  2 ahci,sata_sil24
scsi_mod              161016  2 sd_mod,libata
dock                   14112  1 libata
e1000e                104872  0 
thermal                22688  0 
processor              42304  1 thermal
fan                     9352  0 
thermal_sys            17728  3 thermal,processor,fan
intel-ss4200:~# exit

Script done on Fri 29 Jan 2010 06:50:08 PM EST

--------------060900040809010607010700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------060900040809010607010700--
