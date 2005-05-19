From: jthiessen@penguincomputing.com (Justin Thiessen)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: Ticket #1851 - PATCH (take 2) for adm1026.c, kernel 2.6.10-bk6
Message-Id: <20050103213707.GA12765@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D5D075.4000200@paradyne.com>
 <20050101001205.6b2a44d3.khali@linux-fr.org>
 <20050103194355.GA11979@penguincomputing.com>
 <20050103201056.3c55e330.khali@linux-fr.org>
In-Reply-To: <20050103201056.3c55e330.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>

On Mon, Jan 03, 2005 at 08:10:56PM +0100, Jean Delvare wrote:
> Hi Justin,
> 

<patch snipped>

> Mmm, I don't like this fix.
> 
> For one thing, it still leaves some room for someone to call a sysfs
> callback function before the values are all intialized (because you
> create the sysfs files interface first, then intialize all the values).
>
> For another, this change will significantly increase the driver loading
> time. Just check it! SMBus is slow and the ADM1026 has a lot of
> registers.

Good points.  

<snilp>

> Alternatives I can think of are:
> 
> 1* Only intialize the few values that actually can be needed before
> the update function was ever called.
> 
> 2* Call the update function from the write sysfs callback functions
> where needed.

Ick.  Let's go with (1).  A quick review of the adm1026_set_* functions 
doesn't seem to turn up any other situations where unextracted hardware 
defaults should cause any problems.  In all other cases where a set
function depends on data->* values that may not have been set, the
data->* value default of 0 results in the desired behavior.

So let's just have the adm1026_init_client() function read the hardware
fan divisor values and store them in fan*_div.

<snip>

> ...That said, the relevant code could be moved to a
> separate function, called by both the detect/init and update functions,
> so that no slowdown occurs (except for the extra function call, but
> that's nothing compared to the SMBus slowness) and the code is still not
> duplicated.

The amount of duplicated code is only a few lines, and I think the result is
clearer if it is not extracted into a separate function.  See the following
patch.

Signed-off-by: Justin Thiessen <jthiessen@penguincomputing.com>

-------------------

--- linux-2.6.10/drivers/i2c/chips/adm1026.c.orig	2005-01-02 15:21:58.000000000 -0800
+++ linux-2.6.10/drivers/i2c/chips/adm1026.c	2005-01-02 18:27:40.695689832 -0800
@@ -452,6 +452,15 @@ void adm1026_init_client(struct i2c_clie
 		client->id, value);
 	data->config1 = value;
 	adm1026_write_value(client, ADM1026_REG_CONFIG1, value);
+
+	/* initialize fan_div[] to hardware defaults */
+	value = adm1026_read_value(client, ADM1026_REG_FAN_DIV_0_3)
+		| (adm1026_read_value(client, ADM1026_REG_FAN_DIV_4_7)
+		<< 8);
+	for (i = 0;i <= 7;++i) {
+		data->fan_div[i] = DIV_FROM_REG(value & 0x03);
+		value >>= 2;
+	}
 }
 
 void adm1026_print_gpio(struct i2c_client *client)

