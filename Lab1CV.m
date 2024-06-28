% Matrix Operations:
% Implement a function that multiplies two matrices using a basic algorithm
% (not relying on built-in functions).

% Define matrices A and B
A = [5, 2; 3, 4; 7, 9];
B = [5, 6; 7, 8];

% Function to multiply two matrices
function C = matrix_multiply(A, B)
  % Get the dimensions of matrices A and B
  [m, n] = size(A);
  [p, q] = size(B);

  % Check for compatible dimensions
  if n ~= p
    error('Incompatible matrix dimensions.');
  end

  % Initialize the result matrix C with zeros
  C = zeros(m, q);

  % Perform matrix multiplication
  for i = 1:m
    for j = 1:q
      for k = 1:n
        C(i, j) = C(i, j) + A(i, k) * B(k, j);
      end
    end
  end
end

% Call the function to multiply A and B
C = matrix_multiply(A, B);

% Display the result with a title
disp('Matrix Operations:');
disp('------------------');
disp('Result of Matrix Multiplication (A * B):');
disp(C);
fprintf('\n');


% Numerical Methods:
% Implement a function that approximates the roots of a function using the bisection method.

% Bisection Method implementation
function root = bisectionMethod(f, a, b, epsilon, maxIterations)
    % Check if function values at a and b have opposite signs
    if sign(f(a)) == sign(f(b))
        error("The function values at a and b should have opposite signs.");
    end

    % Initialize iteration counter
    iteration = 0;

    % Bisection method loop
    while abs(b - a) > epsilon && iteration < maxIterations
        % Calculate midpoint
        c = (a + b) / 2;

        % Check if the midpoint is a root
        if abs(f(c)) < epsilon
            root = c;
            fprintf('Converged in %d iterations\n', iteration);
            return;
        end

        % Update the interval
        if sign(f(c)) == sign(f(a))
            a = c;
        else
            b = c;
        end

        % Increment the iteration counter
        iteration = iteration + 1;
    end

    % Assign the midpoint as the root approximation
    root = (a + b) / 2;
    fprintf('Converged in %d iterations\n', iteration);
end

% Example usage for bisection method
f1 = @(x) x^3 - x - 1;  % Define the function
a1 = 1;                 % Interval start
b1 = 2;                 % Interval end
epsilon1 = 1e-6;        % Tolerance
maxIterations1 = 100;   % Maximum iterations

root1 = bisectionMethod(f1, a1, b1, epsilon1, maxIterations1);
fprintf('Numerical Methods:\n');
fprintf('-----------------\n');
fprintf('Approximate root for x^3 - x - 1: %.6f\n\n', root1);


% Sorting Algorithms:
% Implement bubble sort, merge sort, and quicksort.

% Bubble Sort implementation
function sortedArray = bubbleSort(arr)
    n = length(arr);
    sortedArray = arr;
    for i = 1:n-1
        for j = 1:n-i
            if sortedArray(j) > sortedArray(j+1)
                % Swap elements
                temp = sortedArray(j);
                sortedArray(j) = sortedArray(j+1);
                sortedArray(j+1) = temp;
            end
        end
    end
end

% Merge Sort implementation
function sortedArray = mergeSort(arr)
    n = length(arr);
    if n <= 1
        sortedArray = arr;
        return;
    end

    % Divide the array into two halves
    mid = floor(n / 2);
    left = mergeSort(arr(1:mid));
    right = mergeSort(arr(mid+1:end));

    % Merge the sorted halves
    sortedArray = merge(left, right);
end

function mergedArray = merge(left, right)
    l = length(left);
    r = length(right);
    mergedArray = zeros(1, l+r);
    i = 1;
    j = 1;
    k = 1;

    while i <= l && j <= r
        if left(i) <= right(j)
            mergedArray(k) = left(i);
            i = i + 1;
        else
            mergedArray(k) = right(j);
            j = j + 1;
        end
        k = k + 1;
    end

    % Copy remaining elements of left array
    while i <= l
        mergedArray(k) = left(i);
        i = i + 1;
        k = k + 1;
    end

    % Copy remaining elements of right array
    while j <= r
        mergedArray(k) = right(j);
        j = j + 1;
        k = k + 1;
    end
end

% Quicksort implementation
function sortedArray = quickSort(arr)
    n = length(arr);
    if n <= 1
        sortedArray = arr;
        return;
    end

    % Select pivot (using median-of-three for better performance)
    pivot = medianOfThree(arr(1), arr(floor(n/2)), arr(n));

    % Partition the array around the pivot
    left = [];
    right = [];
    for i = 1:n
        if arr(i) < pivot
            left = [left arr(i)];
        elseif arr(i) > pivot
            right = [right arr(i)];
        end
    end

    % Recursively sort left and right partitions
    sortedLeft = quickSort(left);
    sortedRight = quickSort(right);

    % Concatenate sorted partitions with pivot
    sortedArray = [sortedLeft pivot sortedRight];
end

function pivot = medianOfThree(a, b, c)
    if (a <= b && b <= c) || (c <= b && b <= a)
        pivot = b;
    elseif (b <= a && a <= c) || (c <= a && a <= b)
        pivot = a;
    else
        pivot = c;
    end
end

% Example usage for sorting algorithms
arr = [64, 34, 25, 12, 22, 11, 90];
disp('Sorting Algorithms:');
disp('-------------------');

% Bubble Sort
disp('Bubble Sort:');
sortedArr = bubbleSort(arr);
disp(['Sorted Array: ' num2str(sortedArr)]);

% Merge Sort
disp('Merge Sort:');
sortedArr = mergeSort(arr);
disp(['Sorted Array: ' num2str(sortedArr)]);

% Quicksort
disp('Quicksort:');
sortedArr = quickSort(arr);
disp(['Quick Sorted Array: ' num2str(sortedArr)]);
fprintf('\n');


% Search Algorithms:
% Write a function that performs binary search on a sorted array.

% Binary Search implementation
function index = binarySearch(sortedArray, target)
    % Perform binary search on sortedArray
    low = 1;
    high = numel(sortedArray);

    fprintf('Search Algorithms:\n');
    fprintf('-----------------\n');

    fprintf('Binary Search Process:\n');
    fprintf('----------------------\n\n');

    fprintf('Initial sorted array: [');
    fprintf('%d ', sortedArray);
    fprintf(']\n\n');

    fprintf('Target to search: %d\n\n', target);

    fprintf('Starting binary search...\n');
    fprintf('-------------------------\n\n');

    while low <= high
        mid = floor((low + high) / 2);

        % Display current search range and midpoint value
        fprintf('Searching in range [%d, %d] - Midpoint: index %d, value %d\n', low, high, mid, sortedArray(mid));

        % Display what has been searched
        fprintf('Checking value at index %d: %d\n', mid, sortedArray(mid));

        if sortedArray(mid) == target
            index = mid; % Found the target
            fprintf('Found %d at index %d\n', target, index);
            return;
        elseif sortedArray(mid) < target
            low = mid + 1; % Search the right half
            fprintf('Target %d is larger, searching right half\n', target);
        else
            high = mid - 1; % Search the left half
            fprintf('Target %d is smaller, searching left half\n', target);
        end

        fprintf('\n'); % Add spacing between iterations for clarity
    end

    % Target not found
    index = -1;
    fprintf('Target %d not found in the array\n', target);
end

% Example usage for binary search
sortedArray = [11, 12, 22, 25, 34, 64, 90];
target = 22;

fprintf('Binary Search Result: Index %d\n', binarySearch(sortedArray, target));
fprintf('\n');


% Recursion:
% Implement a function that computes factorial using recursion.

% Recursive factorial function
function fact = factorial_recursive(n)
    % Base case: factorial of 0 is 1
    if n == 0
        fact = 1;
    else
        % Recursive case: factorial of n is n times factorial of (n-1)
        fact = n * factorial_recursive(n - 1);
    end
end

% Example usage for factorial function
n = 5;
fprintf('Recursion:\n');
fprintf('----------\n');
fprintf('Factorial of %d is: %d\n\n', n, factorial_recursive(n));


% String Manipulation:
% Write a function that checks if a given string is a palindrome.

% Palindrome checking function
function isPalindrome = checkPalindrome(str)
    % Remove spaces and convert to lowercase
    str = lower(str(str >= 'a' & str <= 'z' | str >= 'A' & str <= 'Z'));

    % Check if the string is a palindrome
    len = length(str);
    isPalindrome = true;
    for i = 1:floor(len/2)
        if str(i) ~= str(len-i+1)
            isPalindrome = false;
            break;
        end
    end
end

% Example usage for palindrome function
str1 = 'A man a plan a canal Panama';
str2 = 'Madam';
str3 = 'Hello';

fprintf('String Manipulation:\n');
fprintf('--------------------\n');
fprintf('Is "%s" a palindrome? %d\n', str1, checkPalindrome(str1));
fprintf('Is "%s" a palindrome? %d\n', str2, checkPalindrome(str2));
fprintf('Is "%s" a palindrome? %d\n\n', str3, checkPalindrome(str3));


% Probability and Statistics:
% Calculate the mean, median, and mode of a given dataset

% Statistics function
function [mean_value, median_value, mode_value] = calculateStats(dataset)
    % Calculate mean
    mean_value = mean(dataset);

    % Calculate median
    median_value = median(dataset);

    % Calculate mode
    counts = hist(dataset, unique(dataset));
    [~, idx] = max(counts);
    mode_value = unique(dataset)(idx);

    % Displaying informative output
    fprintf('Probability and Statistics:\n');
    fprintf('---------------------------\n');
    fprintf('Dataset: %s\n', mat2str(dataset));
    fprintf('Mean: %.2f\n', mean_value);
    fprintf('Median: %.2f\n', median_value);
    fprintf('Mode: %.2f\n', mode_value);
end

% Example usage for statistics function
dataset = [2, 3, 5, 5, 7, 8, 8, 8, 10];
[mean_val, median_val, mode_val] = calculateStats(dataset);

