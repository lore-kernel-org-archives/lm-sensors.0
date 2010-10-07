From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 07 Oct 2010 09:45:26 +0000
Subject: Re: [lm-sensors] Asus P7p55D motherboard sensor issues
Message-Id: <AANLkTikjHzXwH9m634neJRFENhZdLO__Pu6EKkYsBeB6@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTin8LOmkZaGZyYLYKh71F4675M+_V_0=ytc_89z4@mail.gmail.com>
In-Reply-To: <AANLkTin8LOmkZaGZyYLYKh71F4675M+_V_0=ytc_89z4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 6, 2010 at 11:35 PM, Jean Delvare <khali@linux-fr.org> wrote:
> On Wed, 6 Oct 2010 16:15:17 -0400, MrBill wrote:
>> Thanks again.  When you said to grab the asus file from a newer kernel are
>> you telling me to load 11.3 and copy the file or is there somewhere on the
>> net I can download the file.  I have tried to download the asus_atk0110 file
>> before and did not have much success.
>> I do have the source files loaded for my kernel.
>
> If you create a bug report on bugzilla.novell.com and give me the
> number, I can push the required fix to the next maintenance update of
> your openSUSE kernel.
>
> Luca, please point me to the upstream fix for this bug.

8d282497cbf8124d6814d51a74fb13d69531c669: fixes the reading of the
"upper" limit of a sensor.
18e255558574c5663c9d72fe82c099d2115aee55: fixes the AE_BUFFER_OVERFLOW
(this board uses a bigger return buffer)
9e6eba610c2eb68b05841a15ece1cf929c44aea3: enables the EC (otherwise
the readings are not updated)

Unrelated, but you probably also want
a30dcb4f68fb60440f71b3e62bc5c15f631d14f9 which fixes a lockep warning.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
