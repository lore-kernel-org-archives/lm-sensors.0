From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: [gstewart@spamcop.net: Linux kernel / i2c_adapter structure]
Message-Id: <Pine.LNX.4.53.0312192112490.23656@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031219120846.GA655@frodo.local>
In-Reply-To: <20031219120846.GA655@frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 19 Dec 2003, Greg KH wrote:
>
> Use the i2c_get_adapdata() and i2c_set_adapdata() functions to get and
> set a private data pointer.  See the adapter drivers for examples of how
> to use this properly.

Hmm... it goes to adapter.dev.driver_data.

Currently in 2.6 adapter is bound with a "dummy" driver that never
references dev.driver_data. While it does work it is not very clean as
for an i2c_adapter device, the device driver is the algorithm.
Therefore, driver_data should point a structure specific to this
algorithm. IMO, one should move *algo_data and not *data to
dev.driver_data using the functions you mention above, right?
Maybe have i2c_set/get_algodata with current _adapdata function and
consider if we need a _adapdata variant at all.

Often, in place of i2c_get_adapdata, one could use either
container_of() or reference into the algorithm structure which also
has a void pointer for the use of the adapter code.

Some two weeks ago I posted about simplifying i2c-core and I have
it compiling and running now. Will post it with comments some day RSN.

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>
