From: VDR User <user.vdr@gmail.com>
Date: Tue, 23 Feb 2010 17:00:17 +0000
Subject: Re: [lm-sensors] [RFC PATCH v1 0/2] Add the sensors-config tool
Message-Id: <a3ef07921002230900s142e6015qdc97881fb52af1a6@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100219193821.GA1917@andre-laptop>
In-Reply-To: <20100219193821.GA1917@andre-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Feb 23, 2010 at 12:20 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>> 1) How will you deal with board / produty version (we are going to need
>>> =A0 these to uniquely identify some boards)
>>
>> Not sure why this would be an issue..?
>
> This would be an issue when using:
> <some-path>/board_vendor/board_name
>
> To locate the correct config file, as there is no version present in that
> scheme
>
>>> 2) Are you going to handle having multiple board_name's in the same
>>> =A0 config file.
>>
>> Why would this be any problem at all?
>
> The same, this would mean having multiple copies of the same file when us=
ing
> the above dir layout.

Instead of creating a big dir tree, why not just put all the different
config files (which should be named using common sense) into one dir
and maintain a text file which points the
vendor/model/version/whatever_else to the correct file?  Then you can
just grep what you're looking for.  I'm a fan of not making things
harder then they need to be, especially when it can be so simple. ;)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
