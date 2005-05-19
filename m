From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: lm_sensors on Itanium
Message-Id: <20040302205822.33ba5b9c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E4C89F0@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E4C89F0@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marc,

Nice to see you again :)

> I'm trying to get lm_sensors working on a dual Itanium2 1.3 GHz
> whitebox system.  It built and installed just fine, but found no
> sensors.  The output is below.  I saw several messages on the mailing
> list relating to Itanium, but they were very old and included links to
> non-existent web pages.  I didn't see anything relevant in the FAQ. 
> I'm confident that this motherboard has some sort of sensors on it,
> but I'm not yet sure what.  I don't yet have the Intel documentation. 
> My next step is to open the box and look what chips are there.
> 
> Can you give me any guidance?  Have others been trying lm_sensors on
> Itanium?

I don't remember seing much posts about Itaniums since I'm here.

> Probing for PCI bus adapters...
> Sorry, no PCI bus adapters found.

Step 1: find if you do have a SMBus PCI device. "/sbin/lspci | grep -i
smbus" should help.

> modprobe: Can't locate module i2c-dev
>  Loading failed, expect problems later on.

Is it built into the kernel? You really need this, either in the kernel
or as a module, for sensors-detect to work properly.

> Probing for `SMSC 47M10x Super IO Fan Sensors'
>   Failed! (0x51)
> Probing for `SMSC 47M14x Super IO Fan Sensors'
>   Failed! (0x51)

My guess goes to a SMSC 47B27x. It isn't a full hardware monitoring
chip, but has Fan control capabilities.

I'll add detection support to sensors-detect, if you are willing to try
the updated version for confirmation.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
