#BST

class Node
    attr_accessor :data, :left, :right
    def initialize(data)
        @data = data
        @left = nil
        @right = nil
    end
end

class Tree
    #sorts and removes duplicates
    def sort_out(origin_array)
        origin_array.sort!
        origin_array.uniq
    end

    def initialize(array)
        @given_array = sort_out(array)
        
        n = @given_array.length - 1
        @root = build_tree(@given_array, 0, n )

        
    end

    def build_tree(array, start, finish)
        
        if start > finish 
            
            return nil
        else
            mid = (finish + start)/2
            mid.to_i

            node = Node.new(array[mid])

            node.left = build_tree(array, start, mid - 1)

            node.right = build_tree(array, mid + 1, finish)

            return node
        end




    end
    def insert(node=@root, value)

        if node.data == value
            puts "This data point already exists."
            return nil
        elsif node.data < value
            if node.right != nil
                insert(node.right, value)
            else
                node.right = Node.new(value)
            end
        elsif node.data > value
            if node.left != nil 
                insert(node.left, value)
            else
                node.left = Node.new(value)
            end
        end
    end

    def delete(value, node=@root)
       
      
        #checks the current node for the correct value 
        if node.data != value
            
            node = locate(value, node)
           
        end
        #if the locate method returns nil it's because the tree did not contain 
        #the value to be deleted
        if node == nil 
            return nil
        #if the curent node (the root), is the value to be deleted
        elsif node.data == value
            if node.left != nil && node.right != nil
                #successor method used to find the minimum value of the right 
                #node to seek a replacement for the root if there exists
                #a left and right node
                temp = in_order_successor(node)
                node.data = temp.data
                #calls delete again to delete the duplicate value that replaced
                #the original node to be deleted
                delete(temp.data, node.right)
            elsif node.left != nil
                temp = node.left
                node.data = temp.data
                
                delete(temp.data, node.left)
            elsif node.right != nil 
                temp = node.right
                node.data = temp.data
                
                
                delete(temp.data, node.right)
            end
        elsif node.right.data == value
            if node.right.right != nil && node.right.left != nil
                temp = in_order_successor(node.right.right)
                node.right.data = temp.data
                delete(temp.data, node.right.right)
            elsif node.right.right != nil
                node.right = node.right.right
            elsif node.right.left != nil
                node.right = node.right.left
            else
                node.right = nil
            end
        elsif node.left.data == value
            if node.left.right != nil && node.left.left != nil
                temp = in_order_successor(node.left.right)
                node.left.data = temp.data
                delete(temp.data, node.left.right)
            elsif node.left.left != nil
                node.left = node.left.left
            elsif node.left.right != nil
                node.left = node.left.right
            else
                node.left = nil
            end
            

        end
    end
    #locates a node to be deleted
    def locate(value, node=@root)
       
        if node.data < value
            if node.right != nil
                if node.right.data == value
                    return node
                    
                else
                   
                    locate(value, node.right)
                end
            else
                return nil
            end
        elsif node.data > value
            if node.left != nil
                if node.left.data == value
                    
                    return node
                else
                    
                    locate(value, node.left)
                end
            else
                return nil
            end
        end
    end
    #finds the inorder successor to a root with 2 children
    def in_order_successor(current)
        current = current.right
        while current.left != nil
            current = current.left
        end

        return current
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
    
    #finds node corresponding to value given, returns nil if no value is found
    def find(value, node=@root)
        if node.data < value
            if node.right != nil
                if node.right.data == value
                    return node.right
                    
                else
                   
                    find(value, node.right)
                end
            else
                return nil
            end
        elsif node.data > value
            if node.left != nil
                if node.left.data == value
                    
                    return node.left
                else
                    
                    find(value, node.left)
                end
            else
                return nil
            end
        end
    end
end

def space
    5.times{puts "\n"}
end
test_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
my_bst = Tree.new(test_array)
my_bst.pretty_print
space
#puts test_array.sort.uniq
my_bst.insert(53)

my_bst.pretty_print
space
my_bst.delete(999)
my_bst.pretty_print

puts my_bst.find(67)

