From: drasko.draskovic@gmail.com (Drasko Draskovic)
Date: Tue, 01 Aug 2006 15:35:11 +0000
Subject: [lm-sensors] I2C for uCLinux on ARM926EJ (with AMBA bus)
Message-Id: <5ec3d7930608010835x4ae9753fl1c92e59bc40c292f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5ec3d7930608010704g39ff5710u35686e708c152a7d@mail.gmail.com>
In-Reply-To: <5ec3d7930608010704g39ff5710u35686e708c152a7d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 8/1/06, Drasko Draskovic <drasko.draskovic at gmail.com> wrote:
>
>
> Hi. I am working on a custom design that is based on ARM926EJ and AMBA
> bus. OS of choice is uCLinux, patched with RTAI for RT performance. I
> have to implement now I2C support, but looking at the existing driver
> things seem a bit unclear for me.
>
> Here is what I unserstood:
> i2c-core.c is independent of the bus and is kernel module. This should
> be working. But  what about AMBA bus? Is it supported? Is this file for
> support of AMBA located in 'busses' directory? What are algos files? As
> I undersand, these are bus dependent. Is AMBA supported by these?
>
> If there are not, does anyone have idea how these can be written?
>
> How can a proper working of I2C be tested? Can some dummy I2C
> peripheral be created in Linux?
>
> Any information will be more than helpful.
>
>
I also want to ask following things:
ARM has Amba Peripheral I2C Bus Controller (ApI2c), which I guess is a
bridge between Amba and I2C (which comes out of the chip on two pins).
So, can you tell me:
1) what abot 'buses' part? It has to be dependeant on Amba?
2) what about 'chips part? Does it have to depend on ApI2c?
3) Do I have to write only adapter part -- is this the peice of code
that is ApI2c dependant, and not 'chips' part?

I am still not clear which part of driver ('algos', 'busses', and
'chips') depends on what... And waht of existing I can use from existing and
what I
have to write by myself.
Cheers,
Drasko
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060801/54d45e92/attachment.html 
