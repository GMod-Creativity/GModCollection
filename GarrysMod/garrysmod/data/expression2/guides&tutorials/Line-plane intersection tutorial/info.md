# Expression 2 - Line-plane intersection tutorial

## Details

### Author

- Author: feha
- Steam Profile: https://steamcommunity.com/profiles/76561197972236094

### Publication Info

- Title: Line-plane intersection tutorial
- Date (dd-mm-yyyy): 26-03-2010
- Source: https://web.archive.org/web/20110429165506/http://www.wiremod.com/forum/expression-2-discussion-help/19008-line-plane-intersection-tutorial.html
- Source Accessed (dd-mm-yyyy): 28-09-2025

## Description

> [!Note]
> Images are missing

### Introduction

Ok, I was told by some people that reading someones code is not their best way to learn something (even though its well-commented), and that they would like a tutorial instead. So here I respond to that request, and will explain line-plane intersection as well as I can. After reading this tutorial you are (hopefully) going to be able of finding the position your line intersects the plane.

First of all, I will assume you are idiots and explain what a line, a plane and intersection is, so that people who actually dont know it will still have a chance of understanding.

### A Line

This sounds like something simple to understand, and I would argue that it is. For simplicity I will explain this in 2 dimensions, as that means one less variable to work with (and the fact I hardly can paint, especially not 3d).

A line is something that goes from point a to b, just like a line you would draw on a piece of paper. This description does ofcource not assume that it is straight, but I will explain assuming it is, as non-straight lines is harder to use, and I actually got no clue how to do this with them.

If we look at the extrordinary well-made picture below, you will notice how I marked point a and b. The only extraordinary with any point in that graph is that they are a point in the line. The line is infact infinite, and not finite as you can see I drawn. We could however say that it got a direction, which we would in this case say is from A to B (hence the arrow), which could be explained as <ins>direction=B-A</ins>.
<!-- &#108;&#105;&#110;&#101;&#46;.png -->

### A Plane

A plane might also sound easy, but it is infact much more advanced. As you might understand, a plane is something 3-dimensional, so excuse me if my drawings is hard to understand.

A plane is something you could describe by giving the corners, but as a plane in theory is infinite (just like the line), that is not what I am going to do here. A plane is better described by, just like the line, giving a position in the plane, but instead of the directions it stretch out in, we only need one direction. The normal.

As you can see in this awesome drawing, I painted a plane (altough as I said, it actualyl is infinite), inside a box to give a slight 3-dimensional feeling.
As you see I defined a point on this plane, lets call it point (hi point). But as I said you also need something called a normal, this "normal" is a direction vector, which points away from the plane (aka it is perpendicular to the plane). As you see I labeled it N, as in normal (big suprise!). The normal could just aswell be inverted, and still define the same plane, but to define a plane you only need one normal.
<!-- &#112;&#108;&#97;&#110;&#101;&#46;.png -->

### Intersection

Well this is simple to understand. It is chuck. This whole tutorial is to find where on the plane chuck stands, right? Nah it is not that simple, intersection means where one thing goes trough the other, or the point where they blend together (hence why chuck is called the intersect (computer blended into human)).

Lets draw yet another 2-dimensional picture to make sure you understand it. As you can see it is just 2 lines, which intersects eachothers. If you got 2 lines in 2 dimensions, they will intersect eachothers, unless they are parralell (same direction) or lies within eachothers (same direction, but any position on line a, does also exist in line b).
<!-- &#105;&#110;&#116;&#101;&#114;&#115;&#101;&#99;&#116;&#105;&#111;&#110;&#46;.png -->

### Line-Plane Intersection

Ok, we are finally here, the thing this tutorial is actually supposed to be about. You should now know what a line, a plane and a intersection is. Lets combine this. As I explained in the last chapter, 2 lines in 2 dimensions will always intersect, except in 2 cases. The same goes for 1 line and 1 plane in 3 dimensions. The line will always intersect the plane (or other way around if you prefer that), unless the line is parralell to the plane, or the line lies within the plane.

Lets study some e2 code explaining this whole thing, and go trough it, step by step.

```plaintext
#How does line-plane intersection work?
PlanePoint = Holo:pos() #Get a point in the plane
Normal = Holo:up() #Get the normal (a vector perpendicular to the surface) of the plane
LinePoint1 = Origin #Get a point on the line
LinePoint2 = Origin+OriginDirVec #Get a point on the line "after" point 1#
X = (Normal:dot(PlanePoint-LinePoint1))/(Normal:dot(LinePoint2-LinePoint1)) #Not really sure how, but it returns how many times the distance from point 1 to point 2 you need to go from point 1 to reach the intersection
Vec = LinePoint1+X*(LinePoint2-LinePoint1) #Get the intersections position using f(X) = LinePoint1+X*(LinePoint2-LinePoint1)
```

#### Plane

As you see, we start with finding a position on the plane. As I explained earlier, any position will do. After that we get the normal of the plane. With this, we have defined our plane.

#### Line

But to find where the line intersects the plane, we also need to define the line. We do this by getting a point in the line, which for example could be a players `shootPos()`.
As I explained earlier though, we need another point aswell, if it is a players vision, we can get the direction using `eye()`. This is then added to point1, and we got point2.

#### Math

We also need a function to get the position, lets call it `f(X)`. `f(X) = LinePoint1+X*(LinePoint2-LinePoint1)`. I will explain more about it later, but first, lets find out how we figure out `X`.

```plaintext
X = Normal:dot(PlanePoint-LinePoint1)/Normal:dot(LinePoint2-LinePoint1)
```

As you can see this thing uses the dot product (aka scalar product), and to be honest I do not entirely understand it. Azrael helped me in this case though (check page 2-3), so I can give you a better explanation.

What this does, is it calculates how many times the direction vector of the line `(point2-point1)` there is between point1 on the line, and the point where the line intersects the plane.

Now that we explained that, we can also explain `f(X)`, infact, it is required if we want to explain how you can know that `X = Normal:dot(PlanePoint-LinePoint1)/Normal:dot(LinePoint2-LinePoint1)` works.
As I said, `X` is how many times you need to add the lines direction vector to point1 (sure the direction vector can be of any magnitude, but right now we speak of `LinePoint2-LinePoint1`)

```plaintext
f(X) = LinePoint1+X*(LinePoint2-LinePoint1)
```

In short, what this function does, is add the lines direction vector on `LinePoint1`, `X` amount of times, which returns the intersection point on the plane.

If we now start from `f(X)`, we could figure out how you know that `X = Normal:dot(PlanePoint-LinePoint1)/Normal:dot(LinePoint2-LinePoint1)`.

```plaintext
f(X) = LinePoint1+ X * (LinePoint2-LinePoint1)
f(X):dot(N) = PlanePoint:dot(N)
```

Is what we know. If you wonder how we know that `f(X):dot(N) = PlanePoint:dot(N)` there is an explanation a little bit further down.
If we now change `f(X)` to the actual function, we get:

```plaintext
(LinePoint1 + X * (LinePoint2-LinePoint1)):dot(N) = PlanePoint:dot(N)
```

Which can be taken out of its paranthesis which results in:

```plaintext
LinePoint1:dot(N) + X * ((LinePoint2-LinePoint1):dot(N)) = PlanePoint:dot(N)
```

With this, we could put `X` on its own side of the = mark (don't know the mathematical term in english).

```plaintext
X = (PlanePoint:dot(N) - LinePoint1:dot(N)) / (LinePoint2-LinePoint1):dot(N)
```

We could now make the numerator into a single dot-product again:

```plaintext
X = (PlanePoint-LinePoint1):dot(N) / (LinePoint2-LinePoint1):dot(N)
```

That is as you can see the same as I already stated, so we can say:
Q.E.D.

As I said at start of the above segment, `f(X):dot(N) = PlanePoint:dot(N)`. Here is as promised an explanation on how we know that.

`A:dot(B) = 0` if A and B are perpendicular. The normal N is perpendicular to the plane, and for any two points Point1 and Point2 on the plane, Point1-Point2 is within the plane (remember top of this chapter?). As the direction vector we made is within the plane, we know that the normal, which is perpendicular to the plane, also is perpendicular to this direction vector.
And as `A:dot(B) = 0` if A and B are perpendicular, we can say

```plaintext
(r-a):dot(n)=0
```

If we then pull them out of their paranthesis, we get two dot-products:

```plaintext
r:dot(n)-a:dot(n)=0
```

From here, we can add `a:dot(n)` on both sides, and we get:

```plaintext
r:dot(n)=a:dot(n)
```

Q.E.D.

<!-- 
This might be easyer to understand using a picture, but as I suck at painting and I know one that is pretty good, I steal that.

&#112;&#108;&#97;&#110;&#101;&#45;&#108;&#105;&#110;&#101;&#45;&#105;&#110;&#116;&#101;&#114;&#1.gif -->

### Credits/Sources

Azrael - Thnx for explaining the dot product part a bit better for me!

[Intersection of a plane and a line](https://web.archive.org/web/20110429165506/http://local.wasp.uwa.edu.au/~pbourke/geometry/planeline/)  
This is where I read and understood the whole concept of line-plane intersection. It has one flaw tough, it uses a variable named P3, which it never explained what it was (well kind of did, but I did not realise that, as it left out saying it was "any" point on the plane, only that it was on the plane). However, with some reasoning I figured out that was a point on the plane. Also the site where I stole the line-plane intersection image.

I used 3 sites more, but all of them had a flaw, or used a way I felt was more advanced then I wanted to (matrixes or such), so they didnt teach me anything really and dont deserve credits 👿.

### Other

Hope this helped you, if I did or said something wrong, please inform me so, and if you think you can explain some part a bit further, I would be very GLaD.
