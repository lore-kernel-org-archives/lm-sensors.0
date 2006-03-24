From: galak@kernel.crashing.org (Kumar Gala)
Date: Fri, 24 Mar 2006 01:22:59 +0000
Subject: [lm-sensors] [PATCH] i2c: Add support for virtual I2C adapters
Message-Id: <B520BB15-6EF6-4138-95E5-A97DDCE90839@kernel.crashing.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0603231854270.29782-100000@gate.crashing.org> <20060324011349.GC28500@kroah.com>
In-Reply-To: <20060324011349.GC28500@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: khali@linux-fr.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org


On Mar 23, 2006, at 7:13 PM, Greg KH wrote:

> On Thu, Mar 23, 2006 at 06:55:31PM -0600, Kumar Gala wrote:
>> +EXPORT_SYMBOL(i2c_add_virt_adapter);
>> +EXPORT_SYMBOL(i2c_del_virt_adapter);
>
> EXPORT_SYMBOL_GPL() perhaps?

Got no issue with making that change.

- kumar

