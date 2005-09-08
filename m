From: rhirst@levanta.com (Richard Hirst)
Date: Thu, 08 Sep 2005 17:51:34 +0000
Subject: [lm-sensors] i801_smbus 0000:00:1f.3: Bus collision!
Message-Id: <20050908155100.GL8392@levanta.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050907213603.GW8392@levanta.com>
In-Reply-To: <20050907213603.GW8392@levanta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Sep 08, 2005 at 09:56:29AM -0400, Yani Ioannou wrote:
> The bus collisions are expected - both the IPMI BMC (not bmcsensors
> directly) and the i2c modules you have loaded are competing for the
> smbus. However although I've done this (loaded both bmcsensors and i2c
> modules and got bus collisions) its never resulted in a lockup.

The code does this in i801_check_hststs():

        } else if (d->hststs & 0x08) {
                entry->result = -EIO;
                dev_err(&I801_dev->dev, "Bus collision!\n");
                /* Clock stops and slave is stuck in mid-transmission */
        } else if (d->hststs & 0x04) {

and on return from i801_check_hststs() can continue to poke at the
hardware.  That presumably breaks both this transaction and whatever
one it clashed with.  I'd taken the "slave is stuck" comment to be
pretty serious, and assumed this was a "shouldn't happen" error
condition.  Wouldn't it make more sense to use a semaphore or similar
to avoid even attempting the second transaction when the first is
in progress?

Richard

