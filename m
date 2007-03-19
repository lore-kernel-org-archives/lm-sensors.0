From: nicolas@boichat.ch (Nicolas Boichat)
Date: Mon, 19 Mar 2007 04:17:39 +0000
Subject: [lm-sensors] coretemp - take3
Message-Id: <45FE0EE3.2030201@boichat.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <45FDC7A4.9070601@assembler.cz>
In-Reply-To: <45FDC7A4.9070601@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
> Hello all,
>
> I'm CCing all interested parties, if some isn't please tell!
>
> On URL bellow is current version of coretemp driver.
>
> http://ssh.cz/~ruik/patches/

Small glitch in coretemp_init:

    printk(KERN_NOTICE DRVNAME ": This driver uses undocumented features"

        "of Core CPU. Temperature might be wrong!\n");


Prints this in dmesg:

 [46487.231000] coretemp: This driver uses undocumented featuresof Core CPU. Temperature might be wrong!


(Notice the space missing between "features" and "of")

Best regards,

Nicolas


