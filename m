From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [PATCH 2.6] I2C: New hardware monitor driver: adm9240 (2nd try)
Message-Id: <gnj171hr5nba5ev9t5n6ht8lknafpjesid@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5pst6197ke5d20ouv6h0rgokd32mdbsndi@4ax.com>
In-Reply-To: <5pst6197ke5d20ouv6h0rgokd32mdbsndi@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 28 Apr 2005 10:10:27 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:

>
>Hi Grant,
>
>> >	reg = adm9240_read_value(client, ADM9240_REG_CONFIG);
>> >	adm9240_write_value(client, ADM9240_REG_CONFIG,
>> >		(reg | 0x01) & 0x7f);
>>
>> That would fail to start the measurement cycle (...)

Besides lm_sensors 2.9.1 does:

/* Called when we have found a new ADM9240. */
static void adm9240_init_client(struct i2c_client *client)
{
        /* Start monitoring */
        adm9240_write_value(client, ADM9240_REG_CONFIG, 0x01);
}

--Grant.
