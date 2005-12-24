From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 24 Dec 2005 15:46:20 +0000
Subject: [lm-sensors] revisiting __SENSOR_DEVICE_ATTR() and array
Message-Id: <20051224164620.6e274936.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <439A7911.5020904@gmail.com>
In-Reply-To: <439A7911.5020904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> > I'm awaiting for your MAINTAINERS patch :) 
>
> now included.

Thanks, however, this is a bit confusing as you are moving an entry
around while adding your own. Please send a separate patch (to Linus or
Andrew) reordering "PERSONALITY HANDLING" where it belongs. Then send a
separate patch to me adding your own entry for PC87360.

About the pc87360 patch itself:

> -       struct i2c_client *new_client;
> +       struct i2c_client *cli;

I wholeheartedly agree that "new_client" was a uselessly long
identifier (inherited from the first Linux hardware monitoring drivers
6 years ago!) However, "cli" might be a bit short now and possibly
confusing (makes one think of the "clear interrupt" assembly operand).
"client" would probably be a reasonable compromise.

Now I understand that one of the reasons beyind the choice of the new
variable name is to keep lines short and avoid repeated line breaks.
There are a few tricks you could use to achieve the same, while using
"client" instead of "cli":

1* Define the following inline function:

static inline int client_create_file(i2c_client *client, struct device_attribute *attr)
{
        return device_create_file(&client->dev, attr):
}

Then you can create the files that way:

client_create_file(client, &sensor_dev_attr_in0_input.dev_attr);

2* Keep a pointer to client->dev handy, and use it everywhere is
possible:

struct device *dev = &client->dev;

device_create_file(dev, &sensor_dev_attr_in0_input.dev_attr);

This second option is probably better as it avoids repeated dereferences
of the same pointer, so I think it should be more efficient
performance-wise - although such a change doesn't seem to affect the
binary size; maybe gcc optimizes it on its own already.

This change might be a separate, preliminary patch to the SENSOR_ATTR()
one, at your option.

> -       strcpy(new_client->name, name);
> +       strcpy(cli->name, name);

While you're at it, strlcpy is prefered in this case.

> +               for (i=0; i<11; i++) {

Please respect the coding style that was used for this file WRT spaces
around assignment and comparison symbols.

Thanks,
-- 
Jean Delvare

