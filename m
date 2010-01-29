From: Luca Tettamanti <kronos.it@gmail.com>
Date: Fri, 29 Jan 2010 15:28:20 +0000
Subject: Re: [lm-sensors] Help with asus_atk0110 module
Message-Id: <68676e01001290728i4b38c7e0n37f30f018688c59b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <68676e01001290037o64afca82ra3ad2a5556ecb0e6@mail.gmail.com>
In-Reply-To: <68676e01001290037o64afca82ra3ad2a5556ecb0e6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 29, 2010 at 4:20 PM, Juliano F. Ravasi <jravasi@gmail.com> wrote:
> Luca Tettamanti wrote:
>> The module complains when it encounters an error, otherwise is very silent...
>> In this case it seems that it's not even trying to attach to the hwmon
>> interface.
>>
>> I need a copy of the DSDT (/sys/firmware/acpi/tables/DSDT).
>
> A copy of DSDT file is attached.

Ok, you were bitten by this bug:
http://lists.lm-sensors.org/pipermail/lm-sensors/2010-January/027633.html

Fix is already present in Linus' tree, you can find the patch here:
http://lists.lm-sensors.org/pipermail/lm-sensors/2010-January/027647.html

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
