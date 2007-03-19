From: phil_edelbrock@edgedesign.us (Philip Edelbrock)
Date: Mon, 19 Mar 2007 18:12:11 +0000
Subject: [lm-sensors] Call for 2.10.3
Message-Id: <9EB67216-49B4-4B90-B4F2-7E9340263DB2@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070303171327.186cd0f4.khali@linux-fr.org>
In-Reply-To: <20070303171327.186cd0f4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Mar 19, 2007, at 1:35 AM, Jean Delvare wrote:

> On Thu, 15 Mar 2007 07:56:54 +0100, Jean Delvare wrote:
>> On Sat, 3 Mar 2007 17:13:27 +0100, Jean Delvare wrote:
>>> I fear we'll have to release 2.10.3 earlier than originally  
>>> planed. The
>>> sooner would be the better, in fact. Due to new i2c-core cleanups,
>>> libsensors needs again to be updated to anticipate the kernel  
>>> changes
>>> and give our users (and distributions) a chance to upgrade user- 
>>> space
>>> before upgrading their kernel, so they won't break "sensors" and  
>>> other
>>> tools.
>>>
>>> There is no bugfix pending as far as I know. If anyone thinks  
>>> something
>>> in particular needs to be committed before we release 2.10.3, please
>>> speak up.
>>>
>>> Release schedule could look like:
>>> * March 11th: SVN freeze
>>> * March 12th-18th: testing
>>> * March 19th: release
>>
>> We're in the testing phase now, so everyone please test the  
>> current SVN
>> repository and make sure to report any bug you see.
>
> I'm done with testing and things look OK. I think we are ready to
> release.
>
> Phil, please proceed with the release of lm-sensors 2.10.3 as your  
> time
> permits. Notes:
> * libsensors version needs to be bumped.
> * Do no release i2c, there are no changes there since 2.10.2.

OK, sounds good.  I assume the libsensors bump is the minor and not  
major #.  I hope to get this done by the end of my day today.


Phil

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 2439 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070319/26391151/attachment.bin 
