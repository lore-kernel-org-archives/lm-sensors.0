From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 12 Mar 2007 13:11:34 +0000
Subject: [lm-sensors] Patch to fix attaching HWMON devices on I2C-PXA
Message-Id: <20070312141134.1d6ea691.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <df4ec9600703120109j6cb1c848q54cc7c286b3dfaeb@mail.gmail.com>
In-Reply-To: <df4ec9600703120109j6cb1c848q54cc7c286b3dfaeb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matej,

On Mon, 12 Mar 2007 09:09:59 +0100, Matej Kenda wrote:
> During my attempts to use HWMON drivers attached to the PXA I2C
> adapter (XScale PXA 255, ARM architecture) I have found a bug in the
> i2x-pxa driver that prevented using HWMON devices in that adapter at
> all.
> 
> I have fixed the problem and posted the patch to ARM Linux patch database.
> 
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?idB46/1

Thanks for the heads up. Your patch looks OK. Note though that I cannot
push this patch to mainline myself, as it touches arm-specific
structures and as such might need to be synchronized with other
arm-specific patches. So your patch will have to go through the arm
tree.

-- 
Jean Delvare

