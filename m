From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: linux 2.6 port of smsc47m1
Message-Id: <20040502202942.03d787a1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040429023201.89488.qmail@web20802.mail.yahoo.com>
In-Reply-To: <20040429023201.89488.qmail@web20802.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself (again):

> First, there is no lock on read/write. There is a lock for the update
> function, but that's about all. It's obviously not sufficent. Usually,
> drivers have a second lock for read and write operations.

OK, I've added this to the 2.4 driver. Please test if you can.

Please add locking to your 2.6 driver as well. It should be really easy,
just like:

struct smsc47m1_data *data = i2c_get_clientdata(client);
down(&data->lock);
<read or write>
up(&data->lock);

in both smsc47m1_read_value and smsc47m1_write_value.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
