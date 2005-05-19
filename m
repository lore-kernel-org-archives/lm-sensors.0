From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <20040126231842.2c594a71.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I was wrong. Correct is set_fan_div().
> 
> static ssize_t set_fan_div (struct i2c_client *client, struct
> fscher_data *data, const char *buf, size_t count, int nr, int reg)
> {
>    /* supported values: 2, 4, 8 */
>    int v = simple_strtoul(buf, NULL, 10);
> 
>    switch (v)
>    {
>    case 2:    v = 1;    break;
>    case 4:    v = 2;    break;
>    case 8:    v = 3;    break;
>    default:   return -1;
>    }
> 
>    /* bits 2..7 reserved => mask with 0x03 */
>    data->fan_ripple[FAN_INDEX_FROM_NUM(nr)] &= ~0x03;
>    data->fan_ripple[FAN_INDEX_FROM_NUM(nr)] |= v;
> 
>    fscher_write_value(client, reg,
>    data->fan_ripple[FAN_INDEX_FROM_NUM(nr)]); return count;
> }

I think that our policy is best effort, i.e. chose a correct value that
is not too far from what the user asked for. If you're really kind you
do some rounding stuff, at the expense of some CPU cycles. My opinion is
that this case is unlikely to happen, and if it happens it is most
likely an error, so we aren't supposed to be smart.

I think I would handle it that way:
1* v = (v >> 1) & 0x07.
2* v & 0x04 ? -> 3
   v & 0x02 ? -> 2
   else -> 1

Basically this means the following conversion table, if I'm not
mistaking:
0..2 -> 1 (div=2)
3..4 -> 2 (div=4)
5+   -> 3 (div=8)

Should be fast and efficient enough, and keeps the code clear (IMHO at
least).

Is it OK for you?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
