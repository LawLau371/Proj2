#ifndef XMLREADER_H
#define XMLREADER_H

#include <memory>
#include "XMLEntity.h"
#include "DataSource.h"

class CXMLReader{
    private:
        struct SImplementation;
        std::unique_ptr<SImplementation> DImplementation;
        
    public:
        CXMLReader(std::shared_ptr< CDataSource > src);
        ~CXMLReader();
        
        bool End() const;
        bool ReadEntity(SXMLEntity &entity, bool skipcdata = false);
        
    static void StartElementHandler(void *userData, const char *name, const char **atts);
    static void EndElementHandler(void *userData, const char *name);
    static void CharDataHandler(void *userData, const char *data, int len);
};
#endif // XMLREADER_H
