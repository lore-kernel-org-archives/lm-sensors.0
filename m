From: tparcina@lama.hr (=?iso-8859-2?Q?Tomislav_Par=E8ina?=)
Date: Wed, 09 Aug 2006 07:35:48 +0000
Subject: [lm-sensors] Vt1211
Message-Id: <79337FA3BA80774F9FE87BF809C9F3564309C6@stipe.lama.hr>
List-Id: <lm-sensors.vger.kernel.org>
References: <79337FA3BA80774F9FE87BF809C9F3564309A3@stipe.lama.hr>
In-Reply-To: <79337FA3BA80774F9FE87BF809C9F3564309A3@stipe.lama.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> -----Original Message-----
> From: jon.molin at gmail.com [mailto:jon.molin at gmail.com] On 
> Behalf Of Jon
> Sent: 8. kolovoz 2006 16:56
> To: Tomislav Par?ina
> Cc: lm-sensors at lm-sensors.org
> Subject: Re: [lm-sensors] Vt1211
> 
> Did you try compiling it as a module by doing:
> patch kernel with:
> patch -p1 < patch-vt1211-2.6.11.txt
> copy the patched vt1211.c to your homedir or something and do:
> echo "obj-m := vt1211.o" > Makefile
> make -C /path/to/your/kernel2.6/source/dir SUBDIRS=$PWD modules ?
> I got it working by doing that on the patched kernel (for 
> debian-stable with 2.6.8 but it ought to be pretty much the same)

Hi Jon,

I'll try that if this one with pre-compiled driver fails. Can you send me your's vt1211.ko driver binary? I hope it will work that way.

Tomislav

