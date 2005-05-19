From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: /lib/modules/$(KERNELVER)/kernel/drivers/sensors left empty
Message-Id: <3EE7BF0D.1090505@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030608202401.60d0cec0.khali@linux-fr.org>
In-Reply-To: <20030608202401.60d0cec0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

good questions.
I don't know if either problem is worth solving.
The first problem is harmless but the second one could cause trouble.
What installation procedure compresses modules - it is a Red Hat thing or something?
How common is this?

Jean Delvare wrote:
> Hi,
> 
> I noticed that when upgrading from an old lm_sensors to CVS, modules are
> installed to /lib/modules/$(KERNELVER)/kernel/drivers/i2c instead of
> /lib/modules/$(KERNELVER)/kernel/drivers/sensors. Old modules are
> removed, but the directory itself isn't. Shouldn't we delete it as well?
> Or could possibly be there something that doesn't belong to us?
> 
> Also, modules are removed if and only if they are uncompressed. .o.gz
> (do .o.bz2 exist?) modules are not. I know we don't compress modules,
> but maybe removing any existing module could solve possible issues
> before they arise. Comments on this would be welcome.
> 
