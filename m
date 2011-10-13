From: Michael Hennerich <michael.hennerich@analog.com>
Date: Thu, 13 Oct 2011 06:12:43 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon:lm75 add ADT75 support - requires
Message-Id: <4E96815B.7090600@analog.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3530586362965865477=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1318412218-4237-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1318412218-4237-1-git-send-email-michael.hennerich@analog.com>
To: lm-sensors@vger.kernel.org

--===============3530586362965865477==
Content-Type: multipart/alternative;
	boundary="------------060707040005040205090104"

--------------060707040005040205090104
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 10/12/2011 06:02 PM, Guenter Roeck wrote:
> On Wed, 2011-10-12 at 11:47 -0400, Jean Delvare wrote:
>> On Wed, 12 Oct 2011 11:36:58 +0200, michael.hennerich@analog.com wrote=
:
>>> From: Michael Hennerich<michael.hennerich@analog.com>
>>>
>>> The Analog Devices ADT75 has an additional register at 0x04
>>> for initiating oneshot captures. It is not actively used in
>>> this driver but we must avoid assuming it will behave as
>>> 0x05-0x07 do and return the last read value. In fact register 0x04
>>> reads the same as register 0x00. And all registers are repetitive
>>> mirrored around register 0x04. This fact is used to detect the ADT75.
>> I object. The detection of the original LM75 is there for historical
>> reasons (that chip was very popular on PC motherboards at the end of
>> the 90's. Other compatible chips were never so popular on PC
>> motherboards and this is the reason why they are _not_ detected by the
>> lm75 driver. If you have any of these chips, you have to instantiate
>> them explicitly.
>>
>> Same goes for the ADT75. I don't expect it on PC boards, but rather on
>> embedded designs where it should simply be instantiated, rather than
>> detected.
>>
>> It's still fine to document the ADT75 as being supported by the driver=
,
>> and adding an lm75_type enum value for it. But no detection, please.
>>
> Good point. I am fine with that.
I'm fine with that too. Auto-detect will always be problematic without
dedicated id registers. I'll submit a new patch shortly.
> Turns out the chip I referred to in my other e-mail is a TI TMP75. It
> won't be detected either, but works fine in our design because I
> instantiate it with i2c_register_board_info() during board
> initialization. Which is why I never noticed that auto-detection does
> not work for it.
Considering the number of other LM75 derivatives this driver=20
supports.Text oder Webseite =C3=BCbersetzen
I had wondered if every derivativehad the same behavioron unspecified=20
registers.

Meinten Sie: Ich h=C3=A4tte mich gewundert, */wenn/* sich gleich verhalte=
n h=C3=A4tten
Geben Sie Text oder eine Website-Adresse ein oder lassen Sie ein=20
Dokument =C3=BCbersetzen <http://translate.google.de/?tr=3Df&hl=3Dde>.
Abbrechen <http://translate.google.de/?tr=3Dt&hl=3Dde>


      =C3=9Cbersetzung von Deutsch nach Englisch

--=20

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif


--------------060707040005040205090104
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#ffffff" text=3D"#000000">
    On 10/12/2011 06:02 PM, Guenter Roeck wrote:
    <blockquote cite=3D"mid:1318435354.2454.33.camel@groeck-laptop"
      type=3D"cite">
      <pre wrap=3D"">On Wed, 2011-10-12 at 11:47 -0400, Jean Delvare wrot=
e:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">On Wed, 12 Oct 2011 11:36:58 +0200, <a class=3D"mo=
z-txt-link-abbreviated" href=3D"mailto:michael.hennerich@analog.com">mich=
ael.hennerich@analog.com</a> wrote:
</pre>
        <blockquote type=3D"cite">
          <pre wrap=3D"">From: Michael Hennerich <a class=3D"moz-txt-link=
-rfc2396E" href=3D"mailto:michael.hennerich@analog.com">&lt;michael.henne=
rich@analog.com&gt;</a>

The Analog Devices ADT75 has an additional register at 0x04
for initiating oneshot captures. It is not actively used in
this driver but we must avoid assuming it will behave as
0x05-0x07 do and return the last read value. In fact register 0x04
reads the same as register 0x00. And all registers are repetitive
mirrored around register 0x04. This fact is used to detect the ADT75.
</pre>
        </blockquote>
        <pre wrap=3D"">
I object. The detection of the original LM75 is there for historical
reasons (that chip was very popular on PC motherboards at the end of
the 90's. Other compatible chips were never so popular on PC
motherboards and this is the reason why they are _not_ detected by the
lm75 driver. If you have any of these chips, you have to instantiate
them explicitly.

Same goes for the ADT75. I don't expect it on PC boards, but rather on
embedded designs where it should simply be instantiated, rather than
detected.

It's still fine to document the ADT75 as being supported by the driver,
and adding an lm75_type enum value for it. But no detection, please.

</pre>
      </blockquote>
      <pre wrap=3D"">Good point. I am fine with that.
</pre>
    </blockquote>
    I'm fine with that too. Auto-detect will always be problematic
    without<br>
    dedicated id registers. I'll submit a new patch shortly. =C2=A0 <br>
    <blockquote cite=3D"mid:1318435354.2454.33.camel@groeck-laptop"
      type=3D"cite">
      <pre wrap=3D"">
Turns out the chip I referred to in my other e-mail is a TI TMP75. It
won't be detected either, but works fine in our design because I
instantiate it with i2c_register_board_info() during board
initialization. Which is why I never noticed that auto-detection does
not work for it.
</pre>
    </blockquote>
    Considering the number of other LM75 derivatives this driver
    supports.<input name=3D"js" value=3D"n" id=3D"js" type=3D"hidden"><in=
put
      name=3D"prev" value=3D"_t" id=3D"prev" type=3D"hidden"><input name=3D=
"hl"
      value=3D"de" id=3D"hl" type=3D"hidden"><input name=3D"ie" value=3D"=
UTF-8"
      type=3D"hidden"><input name=3D"layout" value=3D"2" type=3D"hidden">=
<input
      name=3D"eotf" value=3D"1" type=3D"hidden"><label for=3D"source"
      style=3D"display: none;">Text oder Webseite =C3=BCbersetzen</label>=
<span
      id=3D"result_box" class=3D"long_text short_text" lang=3D"en"><span
        class=3D"hps"><br>
        I had</span> <span class=3D"hps">wondered</span> <span
        class=3D"hps">if</span> every derivative<span class=3D"hps"> had<=
/span>
      <span class=3D"hps">the same</span> <span class=3D"hps">behavior</s=
pan><span
        class=3D""> on unspecified registers.<br>
        <br>
      </span></span>
    <div id=3D"gt-src-c" class=3D"g-unit">
      <div id=3D"gt-src-p">
        <div class=3D"" id=3D"gt-src-wrap">
          <div id=3D"spelling-correction" class=3D"gt-spell-correct-messa=
ge
            gt-spell-vkeyboard-on" style=3D"display: none;">Meinten Sie: =
<a>Ich
              h=C3=A4tte mich gewundert, <b><i>wenn</i></b> sich gleich
              verhalten h=C3=A4tten</a></div>
          <div id=3D"gt-src-tools">
            <div id=3D"gt-src-tools-l">
              <div class=3D"" id=3D"inputt13n" style=3D"display: none;"><=
span
                  tabindex=3D"0" dir=3D"ltr" style=3D"-moz-user-select: n=
one;"
                  role=3D"checkbox" class=3D"jfk-checkbox goog-inline-blo=
ck"
                  id=3D"t13nimg"></span><span id=3D"t13ntext" dir=3D"ltr"=
></span></div>
            </div>
            <div id=3D"gt-src-tools-r">
              <div style=3D"-moz-user-select: none; display: none;"
                role=3D"button" class=3D"trans-listen-button
                goog-toolbar-button" id=3D"gt-src-listen"><span
                  class=3D"jfk-button-img"></span></div>
              <div role=3D"button" class=3D"trans-roman-button
                goog-toolbar-button" style=3D"display: none;
                -moz-user-select: none;" id=3D"gt-src-roman"><span
                  class=3D"jfk-button-img"></span></div>
            </div>
          </div>
        </div>
        <div id=3D"select_document" style=3D"display: none;">Geben Sie Te=
xt
          oder eine Website-Adresse ein oder <a
            href=3D"http://translate.google.de/?tr=3Df&amp;hl=3Dde">lasse=
n Sie
            ein Dokument =C3=BCbersetzen</a>.</div>
        <div id=3D"file_div" class=3D"file" style=3D"display: none;">
          <div style=3D"display: none;" id=3D"select_text"><a
              href=3D"http://translate.google.de/?tr=3Dt&amp;hl=3Dde">Abb=
rechen</a></div>
          <input style=3D"display: none;" name=3D"file" id=3D"file" size=3D=
"40"
            type=3D"file"></div>
      </div>
    </div>
    <div id=3D"autotrans" style=3D"display: none; visibility: visible;"
      class=3D"">
      <h3 id=3D"headingtext" class=3D"">=C3=9Cbersetzung von Deutsch nach
        Englisch</h3>
    </div>
    -- <br>
    <pre class=3D"moz-signature" cols=3D"72">Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif</pre>
  </body>
</html>

--------------060707040005040205090104--


--===============3530586362965865477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3530586362965865477==--
