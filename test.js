
var test = function(nums1, nums2) {
  var small = [];
  var big = [];
  if (!nums1.length || !nums2.length) {
    small = nums1.length ? nums1 : nums2;
  } else {
    if (nums1[0] > nums2[0]) {
      big = nums1;
      small = nums2;
    } else {
      big = nums2;
      small = nums1;
    }
  
    for(var i = 0; i < big.length; i++) {
      for(var j = 0, lenj = small.length; j < lenj; j++) {
        if (small[j] > big[i]) {
          small.splice(j, 0, big[i]);
          break;
        }
        if (j === lenj - 1) {
          small.push(big[i]);
        }
      }
    }
  }
  var count = small.length % 2 || 2;
  var median = Math.ceil((small.length - 1) / 2);
  console.log(small);
  if (count === 2) {
    return (small[median - 1] + small[median]) / 2;
  }

  return small[median];
};

console.log(test([1,2,3,4,5,6], [4,5,6,7,8]));
console.log(test([1,2,3,4,5,6], [4,5,6,7,8,9]));
console.log(test([1,2,3], [4,5,6,7,8,9]));
console.log(test([1], [4,5,6,7,8,9]));
console.log(test([1,2,3,10,11], [4,5,6,7,8,9]));
console.log(test([1,3], [2]));
console.log(test([], [2]));
console.log(test([], []));