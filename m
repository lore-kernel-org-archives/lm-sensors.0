From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 24 Feb 2010 13:58:56 +0000
Subject: Re: [lm-sensors] [RFC PATCH v1 0/2] Add the sensors-config tool
Message-Id: <4B8530A0.9010603@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100219193821.GA1917@andre-laptop>
In-Reply-To: <20100219193821.GA1917@andre-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 02/23/2010 09:35 PM, Andre Prendel wrote:
> On Mon, Feb 22, 2010 at 10:26:47PM +0100, Hans de Goede wrote:
>> Hi,
>
> Hello,
>
>> On 02/22/2010 09:28 PM, Andre Prendel wrote:
>
>> Well, we can have one config file which is valid for multiple versions /
>> variants (think extra slots, extra onboard nic, whatever) boards, I
>> think we should not have multiple copies of that file then, using
>> a hierarchy with multiple levels is fine by me too, but then:
 >>
>> 1) How will you deal with board / produty version (we are going to need
>>     these to uniquely identify some boards)
>> 2) Are you going to handle having multiple board_name's in the same
>>     config file.
>
> I like the multiple level directory layout because printing all
> vendors or all boards for a specific vendor is a simple directory
> listing (see -l and -b options). BTW I like a clean layout.
>
> Of course we can encode the version by another directory level or in
> the board name, couldn't we?
>
> To avoid multiple files for the same board we could place the symlinks
> into root directory. This layout would also avoid the problem of
> identical board names of different vendors.
>

Having multiple directory levels is fine by me. I was merely
pointing out that there are some issues with that approach.

Thinking of this another possible issue is that vendors don't
always use the same vendor string in the DMI data.

So I think that the following would be a good solution:

1 dir per vendor, with vendor board configs in there, just like
the wiki.

symlinks in the base dir following the symlink structure I suggested
earlier.

This way we get the best of both worlds I think.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
