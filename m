From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 10 Dec 2009 21:08:14 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (asus_atk0110): Refactor interface
Message-Id: <68676e00912101308k9e26269v696acd653b533933@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091207160725.GA24212@nb-core2.darkstar.lan>
In-Reply-To: <20091207160725.GA24212@nb-core2.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Thu, Dec 10, 2009 at 9:00 PM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Luca,
>
> On Mon, 7 Dec 2009 17:07:25 +0100, Luca Tettamanti wrote:
>> The behaviour is unmodified, this makes easier to override the heuristic (which
>> is probably needed for some boards).
>>
>> Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
>> ---
>> Will follow up with another patch that depends on this one.
>>
>>  drivers/hwmon/asus_atk0110.c |   98 +++++++++++++++++++------------------------
>>  1 file changed, 44 insertions(+), 54 deletions(-)
>
> Applied, thanks.

Do you have any comment on the other patch (debugfs)?

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
