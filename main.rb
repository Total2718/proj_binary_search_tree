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
    def insert(node=@root,value)

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

    def check_nodes(node,value)
        
    
    end
    

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
      end
end


test_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
my_bst = Tree.new(test_array)
my_bst.pretty_print
puts test_array.sort.uniq
my_bst.insert(53)
my_bst.pretty_print
