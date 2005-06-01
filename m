From: grant_lkml@dodo.com.au (Grant Coady)
Date: Wed, 01 Jun 2005 22:22:36 +0000
Subject: [lm-sensors] PATCH i2c: adm9240 driver doc
Message-Id: <gd5s91195en96c6nhrk3jgffmso8tpkp7u@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <rhsq915s84h66e4ncuam104kfsdhf1onc9@4ax.com>
In-Reply-To: <rhsq915s84h66e4ncuam104kfsdhf1onc9@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,
On Wed, 01 Jun 2005 17:01:36 +0200, Rudolf Marek <r.marek@sh.cvut.cz> wrote:

Thank you for review.  I'm old fashioned and disagree on one point only, 
double space after <period> was standard practice for plaintext monospace 
documents before we got proportional fonts...

>Please avoid using tabs in document if possible.
Okay
>Please  Prefix: 'adm9240' with same quotes
Yes
>Please put url to PDF
Okay
>> +Interface
>> +====>
>----------
>
>As others has this one
Okay
>
>Please remove all double spaces '  ' they may be somewhere else too
>
Don't like but can do :)

>> +Note: changing the fan clock divider does NOT change the fan speed reading, 
>> +it adjusts the internal measurement range so that the 8-bit fan clock 
>> +counter does not overflow.  The datasheet rpm values assume two pulses per 
>> +fan revolution.  If your fan differs from two pulses per revolution, scale 
>> +the fan speed reading in user-space.
>
>We removed this information about pulse/per revolution from other drivers
Alright
>> +ADM9240 has a very fast 320us temperature and voltage measurement cycle 
>> +with independent fan speed measurement cycles counting alternating rising 
>> +edges of the fan tacho inputs.  Comparisons are described as "exceeds 
>> +limit."
>
>I lost context about "Comparisions"
You're right, messy...  rewrite section.

Thank you, I need to add another accessor to driver in response to 
user request, will update doc again after that, including a little 
more info and your changes.  Double space after a period in plaintext 
I only been doing for last 1/4 century or so :(

--Grant.
