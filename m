From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: i2c bus classes in 2.6
Message-Id: <Pine.LNX.4.53.0401031431290.27769@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031230212940.2d21c683.khali@linux-fr.org>
In-Reply-To: <20031230212940.2d21c683.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 30 Dec 2003, Jean Delvare wrote:
> I think I remember that Ky?sti was quite interested in classes because
> it would let us ignore non-SMBus adapters in sensors. Not sure how
> great it is however, since actually we should look for specific chips,
> not specific adapters.

I was referring to a class_device in the driver-model. Registering a
sensor as a class device would at minimum create symbolic links to
sensor chips in a common directory under sysfs, no matter which hw bus
implementation they have.

The class test with adapter and driver is something different.
I don't know where this part of the code came from but the purpose
seems clear, to prevent, eg. tuner driver unintentionally probing on an
SMBus clock generator.

A related issue is i2c_clients_command. For every client on an adapter,
it calls client->driver->command(client, cmd, data) if specified.  This
blindly assumes a global enumeration of cmd, which is not true.

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>
