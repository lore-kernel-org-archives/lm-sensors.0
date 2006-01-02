From: jim.cromie@gmail.com (Jim Cromie)
Date: Mon, 02 Jan 2006 19:20:17 +0000
Subject: [lm-sensors] hwmon-sensor-attr-array-2.patch
Message-Id: <43B97CF1.1050506@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <43B306FB.9040301@gmail.com>
In-Reply-To: <43B306FB.9040301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans de Goede wrote:

>
>
> Jean Delvare wrote:
>
>> Hi Jim,
>>
>> Jim Cromie wrote:
>>
>>> This patch refactors SENSOR_DEVICE_ATTR_2 macro, following pattern 
>>> set by
>>> SENSOR_ATTR.  First it creates a new macro SENSOR_ATTR_2() which 
>>> expands to an initialization expression, then it uses that in 
>>> SENSOR_DEVICE_ATTR_2, which declares and initializes a struct 
>>> sensor_device_attribute_2.
>>
>>
>> Looks OK to me, consider it applied. I won't push it until I am also
>> able to push a driver which uses it though (but that should happen soon
>> enough.)
>>
>> We should probably think of this part of the code and see what can be
>> done to improve it. struct sensor_device_attribute is currently
>> *larger* than struct sensor_device_attribute_2, which makes one wonder
>> if we shouldn't use sensor_device_attribute_2 everywhere even when we
>> don't actually need the second parameter. 
>

I cant help but suspect that alignment issues will eat the space savings,
particularly at non-word boundaries.  But perhaps not on some archs (x86).

>> Also, the field names "index"
>> and "nr" are too generic IMHO and this might get confusing in the long
>> run. I was thinking of "channel" instead of "index". No idea for "nr"
>> though. Or maybe we are generic on purpose for reusability, but then
>> "index" and "nr" should be "nr0" and "nr1" or something equally
>> symmetrical. Thoughts?
>>

Im thinking of a union, something like the following,

struct sensor_device_attribute_2 {
        struct device_attribute dev_attr;
    union {
        u8 info[4];
        struct {
            u8 index, nr;
       } u;
};

but I cant declare the union without giving the element a name 'u',
so derefs to its members would have to change, defeating the point of it.
But maybe Im missing something.

And perhaps a one-time churn isnt too far OOB,
though Im not sufficiently fire-proof to propose it myself ;-)

I agree that the names and (particularly) order are unfortunate.
Normally, when an interface extends another (ie SENSOR_DEVICE_ATTR_2) ,
new params are added to the end of the sig, not inserted in the middle.
(In contrast, .nr was added to end of the struct).

Lastly, it sounds like there may be opporunity to coordinate
any churn of the field names with plans inimated here:

http://lwn.net/Articles/161236/
in Future Driver core changes section.





Hans,  I noticed a few doc-nits.  (havent read for anything else)

>/* Const names for use in the dynamicly genererated in and temp sysfs attr,
>   16 is a bit over kill since there are know known mainboards with 16 in
>  
>
s/know known/no known/

s/over kill/overkill/

<aside>
I thank the Germans (really) for the English willingness to create new 
words out of
smaller ones.   Why say 'pomme de terre' when you can say kartoffel ? 
With apologies to the nation of France  :-D

jimc

