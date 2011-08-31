From: Axel Lin <axel.lin@gmail.com>
Date: Wed, 31 Aug 2011 14:30:51 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (pmbus) Fix the logic of
Message-Id: <CAF+7xWnDSTOJh9cs9tUJdF=k=TD56JN1cMvfNM_ng4vw5Gntyg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314766699.3960.1.camel@phoenix> <20110831120513.31bb62ee@endymion.delvare>
In-Reply-To: <20110831120513.31bb62ee@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org

2011/8/31 Jean Delvare <khali@linux-fr.org>:
> Hi Alex,
It's Axel.

>
> On Wed, 31 Aug 2011 12:58:19 +0800, Axel Lin wrote:
>> If no id is matched, the mid pointer is not NULL in current implementati=
on.
>
> The NULL check is presumably there to catch the (impossible) case
> ARRAY_SIZE(ucd9000_id) =3D 0 (array of ids is empty), not the case "no
> id is matched". The initialization of mid to NULL is for the same
> reason. Both should be unnecessary but may have been motivated by a
> compiler warning (although I would think gcc is smart enough to not
> emit these when it can check that the array isn't empty.) Guenter
> should be able to tell more.
>
> The check for "no id is matched" is !strlen(mid->name), which works as
> intended as far as I can see. Did you actually hit a bug with the
> current code? I bet not.
No, I didn't hit the bug. Just reading the code.

>
> Now I would agree that the current code is somewhat misleading because
> mixing null-terminated arrays with ARRAY_SIZE() is unusual (and
> inefficient - the last iteration always fails.) Also, strlen() is
> relatively slow and would rather be avoided when only testing if a
> string is empty or not: it's faster to test for mid->name[0].
>
> So if anything I would propose the following changes (for performance
> and readability, NOT bug fix), untested:
Your fix looks good to me. ( Although I don't have the h/w for testing ).

>
> --- linux-3.1-rc4.orig/drivers/hwmon/pmbus/ucd9000.c =A0 =A02011-08-30 13=
:41:32.000000000 +0200
> +++ linux-3.1-rc4/drivers/hwmon/pmbus/ucd9000.c 2011-08-31 11:53:28.00000=
0000 +0200
> @@ -141,13 +141,11 @@ static int ucd9000_probe(struct i2c_clie
> =A0 =A0 =A0 =A0block_buffer[ret] =3D '\0';
> =A0 =A0 =A0 =A0dev_info(&client->dev, "Device ID %s\n", block_buffer);
>
> - =A0 =A0 =A0 mid =3D NULL;
> - =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(ucd9000_id); i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mid =3D &ucd9000_id[i];
> + =A0 =A0 =A0 for (mid =3D ucd9000_id; mid->name[0]; mid++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!strncasecmp(mid->name, block_buffer, =
strlen(mid->name)))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 if (!mid || !strlen(mid->name)) {
> + =A0 =A0 =A0 if (!mid->name[0]) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&client->dev, "Unsupported device\=
n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0}
> --- linux-3.1-rc4.orig/drivers/hwmon/pmbus/ucd9200.c =A0 =A02011-08-30 13=
:41:32.000000000 +0200
> +++ linux-3.1-rc4/drivers/hwmon/pmbus/ucd9200.c 2011-08-31 11:53:20.00000=
0000 +0200
> @@ -68,13 +68,11 @@ static int ucd9200_probe(struct i2c_clie
> =A0 =A0 =A0 =A0block_buffer[ret] =3D '\0';
> =A0 =A0 =A0 =A0dev_info(&client->dev, "Device ID %s\n", block_buffer);
>
> - =A0 =A0 =A0 mid =3D NULL;
> - =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(ucd9200_id); i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mid =3D &ucd9200_id[i];
> + =A0 =A0 =A0 for (mid =3D ucd9200_id; mid->name[0]; mid++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!strncasecmp(mid->name, block_buffer, =
strlen(mid->name)))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 if (!mid || !strlen(mid->name)) {
> + =A0 =A0 =A0 if (!mid->name[0]) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&client->dev, "Unsupported device\=
n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0}
>
>
>>
>> Signed-off-by: Axel Lin <axel.lin@gmail.com>
>> ---
>> v2:
>> It seems we don't need to check strlen(mid->name) here.
>> If there is a match, strlen(mid->name) is always not 0.
>> If ther is no match, comparing variable i with ARRAY_SIZE(ucd9000_id)
>> or ARRAY_SIZE(ucd9200_id) is enough.
>>
>> =A0drivers/hwmon/pmbus/ucd9000.c | =A0 =A03 +--
>> =A0drivers/hwmon/pmbus/ucd9200.c | =A0 =A03 +--
>> =A02 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000=
.c
>> index 285bb15..a2d4a72 100644
>> --- a/drivers/hwmon/pmbus/ucd9000.c
>> +++ b/drivers/hwmon/pmbus/ucd9000.c
>> @@ -141,13 +141,12 @@ static int ucd9000_probe(struct i2c_client *client,
>> =A0 =A0 =A0 block_buffer[ret] =3D '\0';
>> =A0 =A0 =A0 dev_info(&client->dev, "Device ID %s\n", block_buffer);
>>
>> - =A0 =A0 mid =3D NULL;
>> =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(ucd9000_id); i++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mid =3D &ucd9000_id[i];
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strncasecmp(mid->name, block_buffer, st=
rlen(mid->name)))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 }
>> - =A0 =A0 if (!mid || !strlen(mid->name)) {
>> + =A0 =A0 if (i =3D ARRAY_SIZE(ucd9000_id)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Unsupported device\n"=
);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> =A0 =A0 =A0 }
>> diff --git a/drivers/hwmon/pmbus/ucd9200.c b/drivers/hwmon/pmbus/ucd9200=
.c
>> index 786f6cd..a72e55e 100644
>> --- a/drivers/hwmon/pmbus/ucd9200.c
>> +++ b/drivers/hwmon/pmbus/ucd9200.c
>> @@ -68,13 +68,12 @@ static int ucd9200_probe(struct i2c_client *client,
>> =A0 =A0 =A0 block_buffer[ret] =3D '\0';
>> =A0 =A0 =A0 dev_info(&client->dev, "Device ID %s\n", block_buffer);
>>
>> - =A0 =A0 mid =3D NULL;
>> =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(ucd9200_id); i++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mid =3D &ucd9200_id[i];
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strncasecmp(mid->name, block_buffer, st=
rlen(mid->name)))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 }
>> - =A0 =A0 if (!mid || !strlen(mid->name)) {
>> + =A0 =A0 if (i =3D ARRAY_SIZE(ucd9200_id)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Unsupported device\n"=
);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> =A0 =A0 =A0 }
>
>
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
