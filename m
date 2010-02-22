From: VDR User <user.vdr@gmail.com>
Date: Mon, 22 Feb 2010 22:40:10 +0000
Subject: Re: [lm-sensors] [RFC PATCH v1 0/2] Add the sensors-config tool
Message-Id: <a3ef07921002221440s656b6e7l5c83204b452ba646@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100219193821.GA1917@andre-laptop>
In-Reply-To: <20100219193821.GA1917@andre-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Feb 22, 2010 at 1:26 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> At the moment the tool is looking under CONFIG_DIR for a directory
>> BOARD_VENDOR and into this directory for a file BOARD_NAME. This could
>> be done as well as from shell script. Yes, we can use sed for regex
>> matching but with the python way installing the automobo.conf is a
>> one-liner encapsulated inside the config tool.
>
> I understand doing the installation of automobo.conf is easier from
> python, but we will get lots of complaints if we try to get distro
> to carry an initscript which depends on python as a default enabled
> initscript.

You are right, you can expect a LOT of complaints if you make an
initscript python-dependent.  Especially when there is no good reason
to do so.  Being able to do it in Python with a one-liner is not even
close to a good reason!

> 1) How will you deal with board / produty version (we are going to need
> =A0 these to uniquely identify some boards)

Not sure why this would be an issue..?

> 2) Are you going to handle having multiple board_name's in the same
> =A0 config file.

Why would this be any problem at all?

> About the translation of spaces to _ in the filenames, I'm not in favor
> of this. filenames with spaces will work fine if the sh script is
> properly written and I would like to avoid invoking numerous sub processes
> in the sysv shell script if possible. OTOH if this becomes too much of a
> pain we can go the replace whitespace by _ route, because it is not
> going to be that much of a penalty.

As you've already pointed out, filenames with spaces is not problem
when the shell script is properly written.  So why bother with any
substitution when it's not even necessary?

Best regards.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
