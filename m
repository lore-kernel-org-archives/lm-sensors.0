From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 23 Feb 2010 08:20:32 +0000
Subject: Re: [lm-sensors] [RFC PATCH v1 0/2] Add the sensors-config tool
Message-Id: <4B838FD0.6060902@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100219193821.GA1917@andre-laptop>
In-Reply-To: <20100219193821.GA1917@andre-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 02/22/2010 11:40 PM, VDR User wrote:
> On Mon, Feb 22, 2010 at 1:26 PM, Hans de Goede<hdegoede@redhat.com>  wrote:
>>> At the moment the tool is looking under CONFIG_DIR for a directory
>>> BOARD_VENDOR and into this directory for a file BOARD_NAME. This could
>>> be done as well as from shell script. Yes, we can use sed for regex
>>> matching but with the python way installing the automobo.conf is a
>>> one-liner encapsulated inside the config tool.
>>
>> I understand doing the installation of automobo.conf is easier from
>> python, but we will get lots of complaints if we try to get distro
>> to carry an initscript which depends on python as a default enabled
>> initscript.
>
> You are right, you can expect a LOT of complaints if you make an
> initscript python-dependent.  Especially when there is no good reason
> to do so.  Being able to do it in Python with a one-liner is not even
> close to a good reason!
>
>> 1) How will you deal with board / produty version (we are going to need
>>    these to uniquely identify some boards)
>
> Not sure why this would be an issue..?
>

This would be an issue when using:
<some-path>/board_vendor/board_name

To locate the correct config file, as there is no version present in that scheme

>> 2) Are you going to handle having multiple board_name's in the same
>>    config file.
>
> Why would this be any problem at all?
>


The same, this would mean having multiple copies of the same file when using
the above dir layout.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
